//
//  Movie.swift
//  Movie App
//
//  Created by oguzhan.deniz on 16.08.2023.
//

import Foundation

struct Movie: Codable {
    let id: Int?
    let title: String?
    let releaseDate: String?
    let posterPath: String?
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
    
    init(id: Int?, title: String?, releaseDate: String?, posterPath: String?, voteAverage: Double?) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.voteAverage = voteAverage
    }
    
    init(movieEntity: MovieEntity) {
        self.id = Int(movieEntity.id)
        self.title = movieEntity.title
        self.releaseDate = movieEntity.releaseDate
        self.posterPath = movieEntity.posterPath
        self.voteAverage = movieEntity.score
    }
    
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
