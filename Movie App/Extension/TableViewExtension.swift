//
//  TableViewExtension.swift
//  Movie App
//
//  Created by oguzhan.deniz on 25.07.2023.
//

import Foundation
import UIKit

extension UITableView {
    
    func register(cellName: String) {
//        string yerine cell alınabilir
        self.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }
    
}
