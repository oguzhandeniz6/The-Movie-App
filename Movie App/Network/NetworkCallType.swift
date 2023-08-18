//
//  NetworkCallType.swift
//  Movie App
//
//  Created by oguzhan.deniz on 15.08.2023.
//

import Foundation

@objc enum NetworkCallType: Int {
    
    case popularMovies
    case topRatedMovies
    case searchMovies
    case searchPersons
    case recommendationMovies
    case movieCredits
    case nowPlaying
    case upcoming
    case genre1
    case genre2
    case genre3
    case all
}
