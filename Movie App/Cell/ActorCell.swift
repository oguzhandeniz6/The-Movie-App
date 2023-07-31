//
//  ActorCell.swift
//  Movie App
//
//  Created by oguzhan.deniz on 31.07.2023.
//

import UIKit

class ActorCell: UICollectionViewCell {
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var characterName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func getClassName() -> String {
        return String(describing: ActorCell.self)
    }
    
    func fillCell(_ actor: Cast) {
        personName.text = actor.original_name
        characterName.text = actor.character
        
        personImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: actor.profile_path ?? ""))
    }

}
