//
//  Genres.swift
//  Movie App
//
//  Created by oguzhan.deniz on 7.08.2023.
//

import Foundation

struct Genres: Codable {
    let genres: [Genre]?
}

struct Genre: Codable {
    
    let id: Int?
    let name: String?
    
}

extension Genre: Equatable {
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id
    }
}
