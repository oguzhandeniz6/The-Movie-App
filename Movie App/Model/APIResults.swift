//
//  PopularResults.swift
//  Movie App
//
//  Created by oguzhan.deniz on 24.07.2023.
//

import Foundation

struct APIResults: Codable {
    let page: Int?
    let results: [Results]?
    let total_pages: Int?
}

struct Results: Codable {
    let id: Int?
    let title: String?
    let release_date: String?
    let poster_path: String?
    let vote_average: Double?
}
