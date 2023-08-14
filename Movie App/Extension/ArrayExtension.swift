//
//  CollectionExtension.swift
//  Movie App
//
//  Created by oguzhan.deniz on 14.08.2023.
//

import Foundation

extension Array {
    
    mutating func getRandomNElement(numOfElms: Int) {
        let length = self.count
        if length > numOfElms {
            for _ in 0 ..< length - numOfElms {
                if let index = self.indices.randomElement() {
                    self.remove(at: index)
                }
            }
        }
    }
}
