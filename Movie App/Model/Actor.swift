//
//  Actor.swift
//  Movie App
//
//  Created by oguzhan.deniz on 28.07.2023.
//

import Foundation

struct Actor : Codable {
    let id: Int?
    let name: String?
    let birthday: String?
    let deathday: String?
    let placeOfBirth: String?
    let biography: String?
    let profilePath: String?
    
    let relatedMovies: RelatedMovies?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case birthday
        case deathday
        case biography
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case relatedMovies = "movie_credits"
    }
}

struct RelatedMovies: Codable {
    let cast: [Movie]?
}
