//
//  Person.swift
//  Movie App
//
//  Created by oguzhan.deniz on 17.08.2023.
//

import Foundation

struct Person: Codable {
    let id: Int?
    let name: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
