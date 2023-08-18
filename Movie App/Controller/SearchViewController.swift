//
//  SearchViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 25.07.2023.
//

import UIKit

var searchController = UISearchController()

class SearchViewController: UIViewController {
    
    private var searchCallType: NetworkCallType = .searchMovies
    
    private var currentPage = 1
    private var totalPages = 1

    private var movies: [Movie] = []
    private var persons: [Person] = []
    private var searchKey: String = ""
    
    private var lastAppendedMovies: [Movie] = []
    private var lastAppendedPersons: [Person] = []
    
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            prepareTableView()
        }
    }
    
    @IBOutlet weak var searchTabBar: UITabBarItem! {
        didSet {
            searchTabBar.title = LocalizationHelper.searchTabBarName.localizeString()
        }
    }
    
    @IBOutlet weak var searchTypeSegmentedControl: UISegmentedControl! {
        didSet {
            searchTypeSegmentedControl.setTitle(LocalizationHelper.searchMovieSegmentName.localizeString(), forSegmentAt: 0)
            searchTypeSegmentedControl.setTitle(LocalizationHelper.searchActorSegmentName.localizeString(), forSegmentAt: 1)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchTableView.reloadData()
    }
    
    @objc func loadData() {
//        Make a network call
        
        switch searchCallType {
        case .searchMovies:
            NetworkService.getMovieList(callType: self.searchCallType, pageNumber: currentPage, searchKey: self.searchKey.percentEncode()) { searchList, maxPage in
                self.searchMovieNetworkHandle(searchList: searchList, maxPage: maxPage)
            }
        case .searchPersons:
            NetworkService.getPersonList(searchKey: searchKey, pageNumber: currentPage) { searchList, maxPage in
                self.searchPersonNetworkHandle(searchList: searchList, maxPage: maxPage)
            }
        default:
            break
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        self.resetTable()
        
        switch searchTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            searchCallType = .searchMovies
        case 1:
            searchCallType = .searchPersons
        default:
            break
        }
    }
    

}

//MARK: - Prepare Extensions

extension SearchViewController {
    
    func prepareTableView() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(cell: MovieCell.self)
        searchTableView.register(cell: PersonCell.self)
        
//        Prepare Pagination
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        searchTableView.refreshControl = refreshControl
    }
}

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch searchCallType {
        case .searchMovies:
            return movies.count
        case .searchPersons:
            return persons.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch searchCallType {
        case .searchMovies:
            
            guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.getClassName(), for: indexPath) as? MovieCell else {
                return MovieCell()
            }
            
            let movie = movies[indexPath.row]
            movieCell.fillCell(movie)
            
            return movieCell
            
        case .searchPersons:
            
            guard let personCell = tableView.dequeueReusableCell(withIdentifier: PersonCell.getClassName(), for: indexPath) as? PersonCell else {
                return PersonCell()
            }
            
            let person = persons[indexPath.row]
            personCell.fillCell(person)
            
            return personCell
            
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == movies.count - 1 || indexPath.row == persons.count - 1), currentPage < totalPages {
            loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch searchCallType {
            
        case .searchMovies:
            if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
                
                nextVC.movieID = movies[indexPath.row].id ?? 0
                
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
        case .searchPersons:
            if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: CastViewController.self)) as? CastViewController {
                
                nextVC.actorID = persons[indexPath.row].id ?? 0
                
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
        default:
            break
        }
    }
    
}

//MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else {
            return
        }
        
        if text == searchKey {
            return
        } else {
            NetworkService.clearRequests()
            resetTable()
            
            searchKey = text

            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(loadData), userInfo: nil, repeats: false)
        }
        
    }
    
}

//MARK: - SearchViewController Extension

extension SearchViewController {
    
    private func resetTable() {
        self.movies.removeAll()
        self.persons.removeAll()
        self.currentPage = 1
        searchTableView.reloadData()
    }
    
    func appendMovies(newMovies: [Movie]) {
        if self.lastAppendedMovies == newMovies {
            return
        }
        self.movies += newMovies
        self.lastAppendedMovies = newMovies
    }
    
    func appendPersons(newPersons: [Person]) {
        if self.lastAppendedPersons == newPersons {
            return
        }
        self.persons += newPersons
        self.lastAppendedPersons = newPersons
    }
    
    func setTotalPages(maxPage: Int) {
        self.totalPages = maxPage
    }
    
    func incrementCurrentPage() {
        self.currentPage += 1
    }
    
    private func searchMovieNetworkHandle(searchList: [Movie], maxPage: Int) {
        self.setTotalPages(maxPage: maxPage)
        self.appendMovies(newMovies: searchList)
        self.incrementCurrentPage()
        self.searchTableView.reloadData()
        self.searchTableView.refreshControl?.endRefreshing()
    }
    
    private func searchPersonNetworkHandle(searchList: [Person], maxPage: Int) {
        self.setTotalPages(maxPage: maxPage)
        self.appendPersons(newPersons: searchList)
        self.incrementCurrentPage()
        self.searchTableView.reloadData()
        self.searchTableView.refreshControl?.endRefreshing()
    }
    
}
