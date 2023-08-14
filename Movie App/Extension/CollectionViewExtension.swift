//
//  CollectionViewExtension.swift
//  Movie App
//
//  Created by oguzhan.deniz on 31.07.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register(cell: UICollectionViewCell.Type) {
        let cellName = String(describing: cell.self)
        self.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
    }
    
    func updateVisibilityAndGetItemCount(list: [Any]) -> Int {
        if list.count == 0 {
            self.isHidden = true
        } else {
            self.isHidden = false
        }
        
        return list.count
    }
    
    func prepareCollectionView(cell: UICollectionViewCell.Type, width: CGFloat, height: CGFloat, scrollDirection: UICollectionView.ScrollDirection = .horizontal, minItemSpacing: CGFloat = 0.0) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.scrollDirection = scrollDirection
        flowLayout.minimumInteritemSpacing = minItemSpacing
        

        self.register(cell: cell)
        self.collectionViewLayout = flowLayout
        
    }
    
}
