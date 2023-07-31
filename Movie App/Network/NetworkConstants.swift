//
//  NetworkConstants.swift
//  Movie App
//
//  Created by oguzhan.deniz on 24.07.2023.
//

import Foundation

struct NetworkConstants {
    
//    URL's and API key
    private static let baseURL: String = "https://api.themoviedb.org/3"
    private static let imageURL: String = "https://image.tmdb.org/t/p/original"
    private static let apiKey: String = "?api_key=98dab9c655a73de7bfb04ab425a53fe2"
    
//    Basic endpoints
    private static let popularEndpoint: String = "/movie/popular"
    private static let searchEndpoint:String = "/search/movie"
    
//    Complex endpoints
    private static let movieEndpoint: String = "/movie/"
    private static let personEndpoint: String = "/person/"
//              credits                  /movie/{movie_id}/credits
//              recommendations          /movie/{movie_id}/recommendations
    
//    Add-ons
    private static let pageAddon: String = "&page="
    private static let queryAddon: String = "&query="
    
    
//MARK: - GET URL Functions
    
//    GET Popular Movies URL
    static func getPopularMoviesURL(pageNumber num: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(popularEndpoint)\(apiKey)\(pageAddon)\(num)")
    }
    
//    GET Search URL
    static func getSearchURL(searchKey key: String, pageNumber num: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(searchEndpoint)\(apiKey)\(queryAddon)\(key)\(pageAddon)\(num)")
    }
    
//    GET Movie URL
    static func getMovieURL(movieID id: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(movieEndpoint)\(id)\(apiKey)")
    }
    
//    GET Movie Credits URL
    static func getMovieCreditsURL(movieID id: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(movieEndpoint)\(id)/credits\(apiKey)")
    }
    
//    GET Movie Recommendations URL
    static func getMovieRecommendationsURL(movieID id: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(movieEndpoint)\(id)/recommendations\(apiKey)")
    }
    
//    GET Person Details URL
    static func getPersonDetailsURL(personID id: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(personEndpoint)\(id)\(apiKey)")
    }
    
//    GET Movie Poster URL
    static func getMovieImageURL(posterPath path: String) -> URL {
        return Utilities.stringToURL("\(imageURL)\(path)")
    }
    
}
