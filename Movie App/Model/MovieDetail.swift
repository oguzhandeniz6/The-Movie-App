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
    let original_title: String?
    let original_language: String?
    let release_date: String?
    let budget: String?
    let revenue: Int?
    let genres: [Genre]?
    let overview: String?
    let runtime: Int?
    let production_companies: [ProductionCompany]?
    let homepage: String?
    
    let vote_average: Double?
    let tagline: String?
    
}

struct Genre: Codable {
    
    let id: Int?
    let name: String?
    
}

struct ProductionCompany: Codable {
    
    let id: Int?
    let name: String?
    let logo_path: String?
    let origin_country: String?
    
}
