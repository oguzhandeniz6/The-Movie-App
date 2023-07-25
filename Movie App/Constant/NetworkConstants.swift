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
    
//    Add-ons
    private let pageAddon: String = "&page="
    private let queryAddon: String = "&query="
    
    
//MARK: - GET URL Functions
    
//    GET Popular Movies URL
    func getPopularMovies(pageNumber num: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(popularEndpoint)\(apiKey)\(pageAddon)\(num)")
    }
    
//    GET Search URL
    func getSearch(searchKey key: String, pageNumber num: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(searchEndpoint)\(apiKey)\(queryAddon)\(key)\(pageAddon)\(num)")
    }
    
//    GET Movie URL
    func getMovie(movieID id: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(movieEndpoint)\(id)\(apiKey)")
    }
    
//    GET Movie Credits URL
    func getMovieCredits(movieID id: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(movieEndpoint)\(id)/credits\(apiKey)")
    }
    
//    GET Movie Recommendations URL
    func getMovieRecommendations(movieID id: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(movieEndpoint)\(id)/recommendations\(apiKey)")
    }
    
//    GET Person Details URL
    func getPersonDetails(personID id: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(personEndpoint)\(id)\(apiKey)")
    }
    
//    GET Movie Poster URL
    func getMoviePoster(posterPath path: String) -> URL {
        return Utilities.stringToURL("\(imageURL)\(path)")
    }
    
}
