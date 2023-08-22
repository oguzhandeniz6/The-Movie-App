//
//  Review.swift
//  Movie App
//
//  Created by oguzhan.deniz on 22.08.2023.
//

import Foundation

struct Review: Codable {
    let author: String?
    let content: String?
    let createdDate: String?
    let updatedDate: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case author
        case content
        case url
        case createdDate = "created_at"
        case updatedDate = "updated_at"
    }
}
