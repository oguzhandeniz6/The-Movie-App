//
//  PaginationCallObject.swift
//  Movie App
//
//  Created by oguzhan.deniz on 5.09.2023.
//

import Foundation

class PaginationCallObject: CallObject {
    
    var pageNumber: Int
    
    init(pageNumber: Int) {
        self.pageNumber = pageNumber
    }
}
