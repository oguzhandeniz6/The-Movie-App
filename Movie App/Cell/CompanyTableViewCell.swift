//
//  CompanyTableViewCell.swift
//  Movie App
//
//  Created by oguzhan.deniz on 8.08.2023.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    
    static let companyCellHeight: CGFloat = 20.0
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyOriginLabel: UILabel!
    
    static func getClassName() -> String {
        return String(describing: Self.self)
    }
    
    func fillCell(_ company: ProductionCompany) {
        self.companyNameLabel.text = company.name ?? ""
        self.companyOriginLabel.text = company.originCountry ?? ""
    }
    
}
