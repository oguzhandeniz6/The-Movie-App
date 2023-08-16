//
//  Credits.swift
//  Movie App
//
//  Created by oguzhan.deniz on 26.07.2023.
//

import Foundation

struct Credits: Codable {
    
    let id: Int?
    let cast: [Cast]?
    
}

struct Cast: Codable {
    
    let id: Int?
    let originalName: String?
    let character: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case character
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}
