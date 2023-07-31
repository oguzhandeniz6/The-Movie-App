//
//  RecommendationCell.swift
//  Movie App
//
//  Created by oguzhan.deniz on 31.07.2023.
//

import UIKit

class RecommendationCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func getClassName() -> String {
        return String(describing: RecommendationCell.self)
    }
    
    func fillCell(_ movie: Results) {
        movieNameLabel.text = movie.title
        
        posterImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: movie.poster_path ?? ""))
    }

}
