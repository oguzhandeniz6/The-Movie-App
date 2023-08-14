//
//  TableViewExtension.swift
//  Movie App
//
//  Created by oguzhan.deniz on 25.07.2023.
//

import Foundation
import UIKit

extension UITableView {
    
    func register(cell: UITableViewCell.Type) {
        let cellName = String(describing: cell.self)
        self.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }
    
}
