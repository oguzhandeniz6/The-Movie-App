//
//  SearchCallObject.swift
//  Movie App
//
//  Created by oguzhan.deniz on 5.09.2023.
//

import Foundation

class SearchCallObject: PaginationCallObject {
    
    var searchKey: String
    
    init(pageNumber: Int, searchKey: String) {
        
        self.searchKey = searchKey
        
        super.init(pageNumber: pageNumber)
    }
}
