//
//  NetworkConstants.swift
//  Movie App
//
//  Created by oguzhan.deniz on 24.07.2023.
//

import Foundation

struct NetworkConstants {
    
    static let shared: NetworkConstants = NetworkConstants()
    
//    URL's and API key
    private let baseURL: String = "https://api.themoviedb.org/3"
    private let imageURL: String = "https://image.tmdb.org/t/p/original"
    private let apiKey: String = "?api_key=98dab9c655a73de7bfb04ab425a53fe2"
    
//    Basic endpoints
    private let popularEndpoint: String = "/movie/popular"
    private let searchEndpoint:String = "/search/movie"
    
//    Complex endpoints
    private let movieEndpoint: String = "/movie/"
    private let personEndpoint: String = "/person/"
//              credits                  /movie/{movie_id}/credits
//              recommendations          /movie/{movie_id}/recommendations
    
    
//MARK: - GET URL Functions
    
//    GET Popular Movies URL
    func getPopularMovies() -> URL {
        if let url = URL(string: "\(baseURL)\(popularEndpoint)\(apiKey)") {
            return url
        } else {
            return URL(string: "www.google.com")!
        }
    }
    
//    GET Search URL
    func getSearch() -> URL {
        if let url = URL(string: "\(baseURL)\(searchEndpoint)\(apiKey)") {
            return url
        } else {
            return URL(string: "www.google.com")!
        }
    }
    
//    GET Movie URL
    func getMovie(movieID id: Int) -> URL {
        if let url = URL(string: "\(baseURL)\(movieEndpoint)\(id)\(apiKey)") {
            return url
        } else {
            return URL(string: "www.google.com")!
        }
    }
    
//    GET Movie Credits URL
    func getMovieCredits(movieID id: Int) -> URL {
        if let url = URL(string: "\(baseURL)\(movieEndpoint)\(id)/credits\(apiKey)") {
            return url
        } else {
            return URL(string: "www.google.com")!
        }
    }
    
//    GET Movie Recommendations URL
    func getMovieRecommendations(movieID id: Int) -> URL {
        if let url = URL(string: "\(baseURL)\(movieEndpoint)\(id)/recommendations\(apiKey)") {
            return url
        } else {
            return URL(string: "www.google.com")!
        }
    }
    
//    GET Person Details URL
    func getPersonDetails(personID id: Int) -> URL {
        if let url = URL(string: "\(baseURL)\(personEndpoint)\(id)\(apiKey)") {
            return url
        } else {
            return URL(string: "www.google.com")!
        }
    }
    
//    GET Movie Poster URL
    func getMoviePoster(posterPath path: String) -> URL {
        if let url = URL(string: "\(imageURL)\(path)") {
            return url
        } else {
            return URL(string: "www.google.com")!
        }
    }
    
}
