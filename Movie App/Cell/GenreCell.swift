//
//  GenreCell.swift
//  Movie App
//
//  Created by oguzhan.deniz on 28.08.2023.
//

import UIKit

class GenreCell: UITableViewCell {

    @IBOutlet weak var genreNameLabel: UILabel!
    @IBOutlet weak var checkmarkImage: UIImageView!
    
    
    static func getClassName() -> String {
        return String(describing: Self.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.checkmarkImage.isHidden = !selected
    }
    
    func fillCell(_ genre: Genre) {
        self.selectionStyle = .none
        self.genreNameLabel.text = genre.name ?? ""
    }
}
