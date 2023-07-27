//
//  FavoriteMoviesViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 27.07.2023.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {
    
    private var movies: [Results] = []
    
    @IBOutlet weak var favoriteTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
