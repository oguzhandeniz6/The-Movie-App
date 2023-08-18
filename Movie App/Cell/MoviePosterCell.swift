//
//  RecommendationCell.swift
//  Movie App
//
//  Created by oguzhan.deniz on 31.07.2023.
//

import UIKit
class MoviePosterCell: UICollectionViewCell {
    
    static let recommendationCellWidth: CGFloat = 120.0
    static let recommendationCellHeight: CGFloat = 200.0
    static let movieCellHeight: CGFloat = 180.0
    
    @IBOutlet weak var alignCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.image = UIConstants.noImage
        }
    }
    @IBOutlet weak var movieNameLabel: UILabel!
    
    static func getClassName() -> String {
        return String(describing: Self.self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        posterImageView.image = UIConstants.noImage
    }
    
    func fillCell(_ movie: Movie) {
        movieNameLabel.text = movie.title
        
        if let posterPath = movie.posterPath {
            posterImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: posterPath, imageSize: PosterSize.high.rawValue))
        }
    }
    
    func setForHomepage() {
        self.movieNameLabel.isHidden = true
        self.alignCenterY.constant = CGFloat.zero
    }

}
