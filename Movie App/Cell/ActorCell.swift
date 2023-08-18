//
//  ActorCell.swift
//  Movie App
//
//  Created by oguzhan.deniz on 31.07.2023.
//

import UIKit

class ActorCell: UICollectionViewCell {
    
    static let actorCellWidth: CGFloat = 100.0
    static let actorCellHeight: CGFloat = 190.0
    
    @IBOutlet weak var personImageView: UIImageView! {
        didSet {
            personImageView.image = UIConstants.noImage
        }
    }
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var characterName: UILabel!
    
    static func getClassName() -> String {
        return String(describing: Self.self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        personImageView.image = UIConstants.noImage
    }
    
    func fillCell(_ actor: Cast) {
        personName.text = actor.originalName
        characterName.text = actor.character
        
        if let posterPath = actor.profilePath {
            personImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: posterPath, imageSize: ProfileSize.high.rawValue))
        }
    }

}
