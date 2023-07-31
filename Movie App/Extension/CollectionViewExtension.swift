//
//  CollectionViewExtension.swift
//  Movie App
//
//  Created by oguzhan.deniz on 31.07.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register(cellName: String) {
        self.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
    }
    
}
