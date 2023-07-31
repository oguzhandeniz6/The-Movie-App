//
//  RecommendationView.swift
//  Movie App
//
//  Created by oguzhan.deniz on 28.07.2023.
//

import UIKit

class RecommendationView: UIView {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    
    static let recommendationViewWidth: CGFloat = 128.0
    static let recommendationViewHeight: CGFloat = 200.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func fillView(movie: Results) {
        self.movieNameLabel.text = movie.title

        if let photo = movie.poster_path {
            self.posterImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: photo))
        }
    }
    
    func commonInit() {
        guard let view = Bundle.main.loadNibNamed("RecommendationView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        addSubview(view)
        view.frame = bounds
    }
    
}
