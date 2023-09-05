//
//  GenreCallObject.swift
//  Movie App
//
//  Created by oguzhan.deniz on 5.09.2023.
//

import Foundation

class GenreCallObject: PaginationCallObject {
    
    var genreId: Int
    
    init(pageNumber: Int, genreId: Int) {
        
        self.genreId = genreId
        
        super.init(pageNumber: pageNumber)
    }
}
