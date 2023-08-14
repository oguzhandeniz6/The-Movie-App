//
//  RecommendationCell.swift
//  Movie App
//
//  Created by oguzhan.deniz on 31.07.2023.
//

import UIKit
// ismini refactor et
class MoviePosterCell: UICollectionViewCell {
//    gösteren ekrana taşınabilir
    static let recommendationCellWidth: CGFloat = 120.0
    static let recommendationCellHeight: CGFloat = 200.0
    static let movieCellHeight: CGFloat = 180.0
    
    @IBOutlet weak var alignCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func getClassName() -> String {
        return String(describing: Self.self)
    }
    
    func fillCell(_ movie: Movie) {
        movieNameLabel.text = movie.title
        
        posterImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: movie.poster_path ?? "", imageSize: PosterSize.high.rawValue))
    }
    
    func setForHomepage() {
        self.movieNameLabel.isHidden = true
        self.alignCenterY.constant = CGFloat.zero
    }

}
