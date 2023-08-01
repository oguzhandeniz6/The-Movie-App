//
//  MovieTableViewCell.swift
//  Movie App
//
//  Created by oguzhan.deniz on 24.07.2023.
//

import UIKit
import Kingfisher
import CoreData

class MovieCell: UITableViewCell {
    
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    
    func fillCell(_ movie: Results) {
        self.selectionStyle = .none
        if let title = movie.title, let rating = movie.vote_average, let releaseDate = movie.release_date, let posterPath = movie.poster_path {
            self.movieTitleLabel.text = title
            self.movieRatingLabel.text = String(format: "%.1f" ,rating)
            self.movieDateLabel.text = Utilities.dateFormatChanger(str: releaseDate)
            self.movieImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: posterPath))
        }
    }
    
    func fillCell(_ movie: NSManagedObject) {
        self.selectionStyle = .none
        
        if let title = movie.value(forKey: CoreDataConstants.titleKeyPath) as? String,
           let rating = movie.value(forKey: CoreDataConstants.scoreKeyPath) as? Double,
           let releaseDate = movie.value(forKey: CoreDataConstants.releaseDateKeyPath) as? String,
           let posterPath = movie.value(forKey: CoreDataConstants.posterPathKeyPath) as? String {
            
            self.movieTitleLabel.text = title
            self.movieRatingLabel.text = String(format: "%.1f" ,rating)
            self.movieDateLabel.text = Utilities.dateFormatChanger(str: releaseDate)
            self.movieImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: posterPath))
            
        }
    }
    
    static func getClassName() -> String {
        return String(describing: MovieCell.self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
