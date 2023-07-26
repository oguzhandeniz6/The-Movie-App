//
//  Credits.swift
//  Movie App
//
//  Created by oguzhan.deniz on 26.07.2023.
//

import Foundation

struct Credits: Codable {
    
    let id: Int?
    let cast: [Cast]
    
}

struct Cast: Codable {
    
    let id: Int?
    let original_name: String?
    let character: String?
    let profile_path: String?
    
}
