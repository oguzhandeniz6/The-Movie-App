//
//  PersonCell.swift
//  Movie App
//
//  Created by oguzhan.deniz on 17.08.2023.
//

import UIKit

class PersonCell: UITableViewCell {
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    
    static func getClassName() -> String {
        return String(describing: Self.self)
    }
    
    func fillCell(_ person: Person) {
        
        self.selectionStyle = .none
        
        self.personNameLabel.text = person.name ?? ""
        if let imagePath = person.profilePath {
            self.personImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: imagePath, imageSize: PosterSize.high.rawValue))
        }
    }
    
}
