//
//  FavoriteMoviesViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 27.07.2023.
//

import UIKit
import CoreData

class FavoriteMoviesViewController: UIViewController {
    
    private var movies: [NSManagedObject] = []
    
    @IBOutlet weak var favoriteTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        movies = CoreDataFunctions.loadMovies()
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
