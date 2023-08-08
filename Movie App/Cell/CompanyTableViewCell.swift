//
//  CompanyTableViewCell.swift
//  Movie App
//
//  Created by oguzhan.deniz on 8.08.2023.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyOriginLabel: UILabel!
    
    static func getClassName() -> String {
        return String(describing: CompanyTableViewCell.self)
    }
    
    func fillCell(_ company: ProductionCompany) {
        self.companyNameLabel.text = company.name ?? ""
        self.companyOriginLabel.text = company.origin_country ?? ""
    }
    
}
