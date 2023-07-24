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

    var popularResults = PopularResults()
    var movies: [Results] = []

    @IBOutlet weak var moviesTableView: UITableView!
    
    func prepareTableView() {
        moviesTableView.dataSource = self
        self.moviesTableView.register(UINib(nibName: MovieCell.getClassName(), bundle: nil), forCellReuseIdentifier: MovieCell.getClassName())
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        moviesTableView.refreshControl = refreshControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        
        
        NetworkManager.shared.fetchDataObject(
            urlString: NetworkConstants.shared.getPopularMovies(),
            dataType: PopularResults.self, completion: { result in
                if let fetchedMovies = result.results, let maxPage = result.total_pages {
                    self.movies = fetchedMovies
                    self.totalPages = maxPage
                }
                self.moviesTableView.reloadData()
            })
    }
    
    @objc func loadData() {
        // Make network call to fetch data for currentPage
        currentPage += 1
        moviesTableView.refreshControl?.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1, currentPage < totalPages {
            loadData()
        }
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

//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}
