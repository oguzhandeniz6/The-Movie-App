//
//  DiscoverCallObject.swift
//  Movie App
//
//  Created by oguzhan.deniz on 4.09.2023.
//

import Foundation

class DiscoverCallObject: PaginationCallObject {
    
    var minYear: String
    var maxYear: String
    var minVote: Float
    var maxVote: Float
    var sortType: SortBy
    var withGenres: String
    
    init(pageNumber: Int, minYear: String, maxYear: String, minVote: Float, maxVote: Float, sortType: SortBy, withGenres: String) {
        
        self.minYear = minYear
        self.maxYear = maxYear
        self.minVote = minVote
        self.maxVote = maxVote
        self.sortType = sortType
        self.withGenres = withGenres
        
        super.init(pageNumber: pageNumber)
    }
}
