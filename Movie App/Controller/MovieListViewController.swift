//
//  MovieListViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 4.09.2023.
//

import UIKit

class MovieListViewController: UIViewController {
    
    var callObject: DiscoverCallObject?
    
    private var currentPage = 1
    private var totalPages = 1

    private var movies: [Movie] = []
    
    @IBOutlet weak var moviesTableView: UITableView! {
        didSet {
            prepareTableView()
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
        if let discoverCallObject = callObject {
            NetworkService.getMovieList(callType: .discover, callObject: discoverCallObject) { movieList, maxPage in
                self.discoverNetworkHandle(discoverList: movieList, maxPage: maxPage)
            }
        }
    }

}

//MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    
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

extension MovieListViewController: UITableViewDelegate {
    
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

//MARK: - MovieListViewController Extension

extension MovieListViewController {
    
    private func prepareTableView() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.register(cell: MovieCell.self)
        
//        Prepare Pagination
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        moviesTableView.refreshControl = refreshControl
    }
    
    private func discoverNetworkHandle(discoverList: [Movie], maxPage: Int) {
        self.setTotalPages(maxPage: maxPage)
        self.appendMovies(newMovies: discoverList)
        self.incrementCurrentPage()
        callObject?.pageNumber = currentPage
        self.moviesTableView.reloadData()
        self.moviesTableView.refreshControl?.endRefreshing()
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
}
