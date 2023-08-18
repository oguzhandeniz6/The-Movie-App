//
//  PersonCell.swift
//  Movie App
//
//  Created by oguzhan.deniz on 17.08.2023.
//

import UIKit

class PersonCell: UITableViewCell {
    
    @IBOutlet weak var personImageView: UIImageView! {
        didSet {
            personImageView.image = UIConstants.noImage
        }
    }
    
    @IBOutlet weak var personNameLabel: UILabel!
    
    static func getClassName() -> String {
        return String(describing: Self.self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        personImageView.image = UIConstants.noImage
    }
    
    func fillCell(_ person: Person) {
        
        self.selectionStyle = .none
        
        self.personNameLabel.text = person.name ?? ""
        
        if let posterPath = person.profilePath {
            self.personImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: posterPath, imageSize: PosterSize.high.rawValue))
        }
    }
    
}
