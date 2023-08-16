//
//  MovieDetail.swift
//  Movie App
//
//  Created by oguzhan.deniz on 26.07.2023.
//

import Foundation

struct MovieDetail: Codable {
    
    let id: Int?
    let title: String?
    let originalTitle: String?
    let posterPath: String?
    let originalLanguage: String?
    let releaseDate: String?
    let budget: Int?
    let revenue: Int?
    let genres: [Genre]?
    let overview: String?
    let runtime: Int?
    let productionCompanies: [ProductionCompany]?
    let homepage: String?
    
    let voteAverage: Double?
    let tagline: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case budget
        case revenue
        case genres
        case overview
        case runtime
        case homepage
        case tagline
        
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case releaseDate = "release_date"
        case productionCompanies
        case voteAverage = "vote_average"
    }
    
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

struct ProductionCompany: Codable {
    
    let id: Int?
    let name: String?
    let logoPath: String?
    let originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}
