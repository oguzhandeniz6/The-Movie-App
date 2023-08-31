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
    
    private var rawMovie: Movie?
    
    private var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                favoriteIcon.image = UIImage(systemName: UIConstants.favoriteIcon)
            } else {
                favoriteIcon.image = UIImage(systemName: UIConstants.unfavoriteIcon)
            }
        }
//        willset incele
//        willSet{
//
//        }
    }
    
    @IBOutlet weak var favoriteIcon: UIImageView! {
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteIconTapped(tapGestureRecognizer:)))
            tapGestureRecognizer.delegate = self
            favoriteIcon.isUserInteractionEnabled = true
            favoriteIcon.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var movieImageView: UIImageView! {
        didSet {
            movieImageView.image = UIConstants.noImage
        }
    }
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    
    static func getClassName() -> String {
        return String(describing: Self.self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        movieImageView.image = UIConstants.noImage
    }
    
    @objc func favoriteIconTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        if let mov = rawMovie, let movId = mov.id {
            if isFavorite {
                CoreDataFunctions.deleteMovie(id: movId)
                isFavorite = false
            } else {
                CoreDataFunctions.saveMovie(movie: mov)
                isFavorite = true
            }
        }
        
        NotificationCenter.default.post(name: .favoriteNotification, object: nil)
    }
    
}

//MARK: - MovieCell Extension

extension MovieCell {
    
    func fillCell(_ movie: Movie) {
        
        self.selectionStyle = .none
        self.rawMovie = movie
        
        if let id = movie.id, let title = movie.title, let rating = movie.voteAverage, let releaseDate = movie.releaseDate {
            
            self.movieTitleLabel.text = title
            self.movieRatingLabel.text = String(format: "%.1f" ,rating)
            self.movieDateLabel.text = FormatChangers.dateFormatChanger(str: releaseDate)
            
//            Favorite System
            if CoreDataFunctions.checkMovie(id: id) {
                self.favoriteIcon.image = UIImage(systemName: UIConstants.favoriteIcon)
                self.isFavorite = true
            } else {
                self.favoriteIcon.image = UIImage(systemName: UIConstants.unfavoriteIcon)
                self.isFavorite = false
            }
        }
        
        if let posterPath = movie.posterPath, posterPath != "" {
            self.movieImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: posterPath, imageSize: PosterSize.high.rawValue))
        }
    }
    
}

