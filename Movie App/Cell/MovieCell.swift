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
    
    private var isFavorite: Bool = false
    
    @IBOutlet weak var favoriteIcon: UIImageView! {
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteIconTapped(tapGestureRecognizer:)))
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    private var movieID: Int = 0
    private var posterPath: String = ""
    private var releaseDate: String = ""
    private var score: Double = 0.0
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    
    func fillCell(_ movie: Results) {
        
        self.selectionStyle = .none
        
        if let id = movie.id, let title = movie.title, let rating = movie.vote_average, let releaseDate = movie.release_date, let posterPath = movie.poster_path {
            
            if CoreDataFunctions.checkMovie(id: id) {
                favoriteIcon.image = UIImage(systemName: Utilities.favoriteIcon)
            }
            
            self.movieID = movie.id ?? 0
            self.posterPath = movie.poster_path ?? ""
            self.releaseDate = movie.release_date ?? ""
            self.score = movie.vote_average ?? 0.0
            
            self.movieTitleLabel.text = title
            self.movieRatingLabel.text = String(format: "%.1f" ,rating)
            self.movieDateLabel.text = Utilities.dateFormatChanger(str: releaseDate)
            self.movieImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: posterPath))
        }
    }
    
    func fillCell(_ movie: NSManagedObject) {
        
        self.selectionStyle = .none
        
        if let id = movie.value(forKey: CoreDataConstants.idKeyPath) as? Int,
           let title = movie.value(forKey: CoreDataConstants.titleKeyPath) as? String,
           let rating = movie.value(forKey: CoreDataConstants.scoreKeyPath) as? Double,
           let releaseDate = movie.value(forKey: CoreDataConstants.releaseDateKeyPath) as? String,
           let posterPath = movie.value(forKey: CoreDataConstants.posterPathKeyPath) as? String {
            
            if CoreDataFunctions.checkMovie(id: id) {
                favoriteIcon.image = UIImage(systemName: Utilities.favoriteIcon)
            }
            
            
            self.movieID = movie.value(forKey: CoreDataConstants.idKeyPath) as? Int ?? 0
            self.posterPath = movie.value(forKey: CoreDataConstants.posterPathKeyPath) as? String ?? ""
            self.releaseDate = movie.value(forKey: CoreDataConstants.releaseDateKeyPath) as? String ?? ""
            self.score = movie.value(forKey: CoreDataConstants.scoreKeyPath) as? Double ?? 0.0
            
            self.movieTitleLabel.text = title
            self.movieRatingLabel.text = String(format: "%.1f" ,rating)
            self.movieDateLabel.text = Utilities.dateFormatChanger(str: releaseDate)
            self.movieImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: posterPath))
            
        }
    }
    
    static func getClassName() -> String {
        return String(describing: MovieCell.self)
    }
    
    @objc func favoriteIconTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        if isFavorite {
            CoreDataFunctions.deleteMovie(id: self.movieID)
            isFavorite = false
            favoriteIcon.image = UIImage(systemName: Utilities.unfavoriteIcon)
        } else {
            CoreDataFunctions.saveMovie(id: self.movieID, score: self.score, title: self.movieTitleLabel.text ?? "", poster_path: self.posterPath, releaseDate: self.releaseDate)
            isFavorite = true
            favoriteIcon.image = UIImage(systemName: Utilities.favoriteIcon)
        }
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
