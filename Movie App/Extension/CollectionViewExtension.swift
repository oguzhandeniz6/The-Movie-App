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
    
    func getNumberOfItems(list: [Any]) -> Int {
//        hidden ı başka yere al ya da ismini değiştir
        if list.count == 0 {
            self.isHidden = true
        } else {
            self.isHidden = false
        }
        
        return list.count
    }
    
    func prepareCollectionView(cellName: String, width: CGFloat, height: CGFloat) {
//        scroll direction ve item spacing i parametre olarak al default ver
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        

        self.register(cellName: cellName)
        self.collectionViewLayout = flowLayout
        
    }
    
}
