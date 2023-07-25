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
    

    @IBOutlet weak var moviesTableView: UITableView!
    
    func prepareTableView() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.register(cellName: MovieCell.getClassName())
        
//        Prepare Pagination
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        moviesTableView.refreshControl = refreshControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        networkCall()
    }
    
    @objc func loadData() {
//        Make network call
        networkCall()
        
        moviesTableView.refreshControl?.endRefreshing()
    }
    
    func networkCall() {
        NetworkManager.shared.fetchDataObject(
            urlString: NetworkConstants.shared.getPopularMovies(pageNumber: currentPage),
            dataType: APIResults.self, completion: { result in
                if let fetchedMovies = result.results, let maxPage = result.total_pages {
                    self.movies += fetchedMovies
                    self.totalPages = maxPage
//                    Increment current page by 1
                    self.currentPage += 1
                }
                self.moviesTableView.reloadData()
            })
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
    
}
