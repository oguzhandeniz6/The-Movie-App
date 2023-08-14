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
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var characterName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func getClassName() -> String {
        return String(describing: Self.self)
    }
    
    func fillCell(_ actor: Cast) {
        personName.text = actor.original_name
        characterName.text = actor.character
        
        personImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: actor.profile_path ?? "", imageSize: ProfileSize.high.rawValue))
    }

}
