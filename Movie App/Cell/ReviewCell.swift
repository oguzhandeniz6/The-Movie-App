//
//  ReviewCell.swift
//  Movie App
//
//  Created by oguzhan.deniz on 22.08.2023.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    
    static func getClassName() -> String {
        return String(describing: Self.self)
    }
    
    func fillCell(_ review: Review) {
        self.nameLabel.text = review.author ?? ""
        self.contentLabel.text = review.content ?? ""
        self.createdLabel.text = FormatChangers.dateFormatChanger(str: review.createdDate ?? "", inputDateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        
        if let updated = review.updatedDate {
            self.updatedLabel.text = FormatChangers.dateFormatChanger(str: updated, inputDateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        } else {
            self.updatedLabel.text = ""
        }
    }
    
}
