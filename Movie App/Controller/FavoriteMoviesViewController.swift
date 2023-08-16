//
//  FavoriteMoviesViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 27.07.2023.
//

import UIKit
import CoreData

class FavoriteMoviesViewController: UIViewController {
    
    var movies: [Movie] = []
    
    @IBOutlet weak var favoriteTableView: UITableView! {
        didSet {
            favoriteTableView.dataSource = self
            favoriteTableView.delegate = self
            favoriteTableView.register(cell: MovieCell.self)
            favoriteTableView.reloadData()
        }
    }
    
    @IBOutlet weak var favoriteTabBar: UITabBarItem! {
        didSet {
            favoriteTabBar.title = LocalizationHelper.favoriteTabBarName.localizeString()
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        movies = CoreDataFunctions.loadMovies()
        favoriteTableView.reloadData()
    }

}

//MARK: - UITableViewDataSource

extension FavoriteMoviesViewController: UITableViewDataSource {
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

extension FavoriteMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
            
            nextVC.movieID = movies[indexPath.row].id ?? 0
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}
