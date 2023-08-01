//
//  FavoriteMoviesViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 27.07.2023.
//

import UIKit
import CoreData

class FavoriteMoviesViewController: UIViewController {
    
    var movies: [NSManagedObject] = []
    
    @IBOutlet weak var favoriteTableView: UITableView! {
        didSet {
            favoriteTableView.dataSource = self
            favoriteTableView.register(cellName: MovieCell.getClassName())
            favoriteTableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        movies = CoreDataFunctions.loadMovies()
        print(movies)
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
            
            if let movId = movies[indexPath.row].value(forKey: CoreDataConstants.idKeyPath) as? Int {
                nextVC.movieID = movId
            }
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}
