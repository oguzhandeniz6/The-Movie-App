//
//  ViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 24.07.2023.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    private var movieListCallType: NetworkCallType = .popularMovies
    
    private var currentPage = 1
    private var totalPages = 1

    private var movies: [Movie] = []
    
    
    @IBOutlet weak var popularTabBar: UITabBarItem! {
        didSet {
            popularTabBar.title = LocalizationHelper.popularTabBarName.localizeString()
        }
    }
    
    @IBOutlet weak var moviesTableView: UITableView!  {
        didSet {
            prepareTableView()
        }
    }
    
    @IBOutlet weak var movieListSegmentedControl: UISegmentedControl! {
        didSet {
            movieListSegmentedControl.setTitle(LocalizationHelper.popularMoviesSegmentName.localizeString(), forSegmentAt: 0)
            movieListSegmentedControl.setTitle(LocalizationHelper.topRatedMoviesSegmentName.localizeString(), forSegmentAt: 1)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        moviesTableView.reloadData()
    }
    
    @objc func loadData() {
//        Make a network call
        NetworkService.getMovieList(callType: movieListCallType, pageNumber: currentPage) { movieList, maxPage in
            self.popularNetworkHandle(popularList: movieList, maxPage: maxPage)
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        resetTable()
        
        switch movieListSegmentedControl.selectedSegmentIndex {
        case 0:
            movieListCallType = .popularMovies
        case 1:
            movieListCallType = .topRatedMovies
        default:
            break
        }
        
        loadData()
    }
    

}

//MARK: - Prepare Extensions

extension PopularMoviesViewController {
    func prepareTableView() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.register(cell: MovieCell.self)
        
//        Prepare Pagination
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        moviesTableView.refreshControl = refreshControl
    }
}

//MARK: - UITableViewDataSource

extension PopularMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
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

extension PopularMoviesViewController: UITableViewDelegate {
    
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

//MARK: - PopularMoviesViewController Extension

extension PopularMoviesViewController {
    
    private func resetTable() {
        self.movies.removeAll()
        self.currentPage = 1
        moviesTableView.reloadData()
    }
    
    func appendMovies(newMovies: [Movie]) {
        self.movies += newMovies
    }
    
    func setTotalPages(maxPage: Int) {
        self.totalPages = maxPage
    }
    
    func incrementCurrentPage() {
        self.currentPage += 1
    }
    
    private func popularNetworkHandle(popularList: [Movie], maxPage: Int) {
        self.setTotalPages(maxPage: maxPage)
        self.appendMovies(newMovies: popularList)
        self.incrementCurrentPage()
        self.moviesTableView.reloadData()
        self.moviesTableView.refreshControl?.endRefreshing()
    }
    
}
