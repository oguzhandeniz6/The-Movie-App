//
//  PopularResults.swift
//  Movie App
//
//  Created by oguzhan.deniz on 24.07.2023.
//

import Foundation
import CoreData

struct APIResults: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}
