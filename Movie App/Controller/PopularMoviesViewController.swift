//
//  ViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 24.07.2023.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    private var currentPage = 1
    private var totalPages = 1

    private var popularResults = APIResults()
    private var movies: [Results] = []
    

    @IBOutlet weak var moviesTableView: UITableView!  {
        didSet {
            prepareTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    @objc func loadData() {
//        Make network call
        NetworkService.getPopularMovies(pageNumber: currentPage, popularVC: self)
        
        moviesTableView.refreshControl?.endRefreshing()
    }

}

//MARK: - Prepare Extensions

extension PopularMoviesViewController {
    func prepareTableView() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.register(cellName: MovieCell.getClassName())
        
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
    
    func appendMovies(newMovies: [Results]) {
        self.movies += newMovies
    }
    
    func setTotalPages(maxPage: Int) {
        self.totalPages = maxPage
    }
    
    func incrementCurrentPage() {
        self.currentPage += 1
    }
    
}
