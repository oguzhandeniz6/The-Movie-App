//
//  SearchViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 25.07.2023.
//

import UIKit

var searchController = UISearchController()

class SearchViewController: UIViewController {
    
    private var currentPage = 1
    private var totalPages = 1

    private var movies: [Movie] = []
    private var searchKey: String = ""
    
    private var lastAppended: [Movie] = []
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    @objc func loadData() {
//        Make network call
        currentPage += 1
        
        NetworkService.getSearchResults(pageNumber: currentPage, searchKey: self.searchKey.percentEncode(), searchVC: self)
        
        searchTableView.reloadData()
        searchTableView.refreshControl?.endRefreshing()
    }
//    load data ve network call nerdeyse aynı, isimlere tekrar bak
    @objc func networkCall() {
        currentPage = 1
        
        NetworkService.getSearchResults(pageNumber: currentPage, searchKey: self.searchKey.percentEncode(), searchVC: self)
        
        searchTableView.reloadData()
    }

}

//MARK: - Prepare Extensions

extension SearchViewController {
    
    func prepareTableView() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(cell: MovieCell.self)
        
//        Prepare Pagination
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        searchTableView.refreshControl = refreshControl
    }
}

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.getClassName(), for: indexPath) as? MovieCell else {
            return MovieCell()
        }
        
        let movie = movies[indexPath.row]
        movieCell.fillCell(movie)
        
        return movieCell
    }
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1, currentPage < totalPages {
            loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
            
            nextVC.movieID = movies[indexPath.row].id ?? 0
            
            self.navigationController?.pushViewController(nextVC, animated: true)
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
        } else if text == "" {
            movies.removeAll()
            searchTableView.reloadData()
        } else {
            NetworkService.clearRequests()
            movies.removeAll()
            
            searchKey = text

            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(networkCall), userInfo: nil, repeats: false)
        }
        
    }
    
}

//MARK: - SearchViewController Extension

extension SearchViewController {
    
    func appendMovies(newMovies: [Movie]) {
        if self.lastAppended == newMovies {
            return
        }
        self.movies += newMovies
        self.lastAppended = newMovies
    }
    
    func setTotalPages(maxPage: Int) {
        self.totalPages = maxPage
    }
    
    func setCurrrentPage(currPage: Int) {
        self.currentPage = currPage
    }
    
    func incrementCurrentPage() {
        self.currentPage += 1
    }
    
}
