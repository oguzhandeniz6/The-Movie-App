//
//  PopularResults.swift
//  Movie App
//
//  Created by oguzhan.deniz on 24.07.2023.
//

import Foundation
import CoreData

struct APIMovieResults: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}

struct APIPersonResults: Codable {
    let page: Int?
    let results: [Person]?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}

struct APIReviewResults: Codable {
    let page: Int?
    let results: [Review]?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}
