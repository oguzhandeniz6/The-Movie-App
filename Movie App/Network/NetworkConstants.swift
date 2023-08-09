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
    private static let imageURL: String = "https://image.tmdb.org/t/p/"
    private static let apiKey: String = "?api_key=98dab9c655a73de7bfb04ab425a53fe2"
    
//    Basic endpoints
    private static let popularEndpoint: String = "/movie/popular"
    private static let searchEndpoint:String = "/search/movie"
    private static let genresEndpoint: String = "/genre/movie/list"
    private static let discoverEndpoint: String = "/discover/movie"
    private static let nowplayingEndpoint: String = "/movie/now_playing"
    private static let upcomingEndpoint: String = "/movie/upcoming"
    
//    Complex endpoints
    private static let movieEndpoint: String = "/movie/"
    private static let personEndpoint: String = "/person/"
//              credits                  /movie/{movie_id}/credits
//              recommendations          /movie/{movie_id}/recommendations
    
//    Add-ons
    private static let pageAddon: String = "&page="
    private static let queryAddon: String = "&query="
    private static let languageAddon: String = "&language="
    private static let genresAddon: String = "&with_genres="
    
    
//MARK: - GET URL Functions
    
//    GET Popular Movies URL
    static func getPopularMoviesURL(pageNumber num: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(popularEndpoint)\(apiKey)\(pageAddon)\(num)\(languageAddon)\(Utilities.getLanguage())")
    }
    
//    GET Search URL
    static func getSearchURL(searchKey key: String, pageNumber num: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(searchEndpoint)\(apiKey)\(queryAddon)\(key)\(pageAddon)\(num)\(languageAddon)\(Utilities.getLanguage())")
    }
    
//    GET Movie URL
    static func getMovieURL(movieID id: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(movieEndpoint)\(id)\(apiKey)\(languageAddon)\(Utilities.getLanguage())")
    }
    
//    GET Movie Credits URL
    static func getMovieCreditsURL(movieID id: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(movieEndpoint)\(id)/credits\(apiKey)\(languageAddon)\(Utilities.getLanguage())")
    }
    
//    GET Movie Recommendations URL
    static func getMovieRecommendationsURL(movieID id: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(movieEndpoint)\(id)/recommendations\(apiKey)\(languageAddon)\(Utilities.getLanguage())")
    }
    
//    GET Person Details URL
    static func getPersonDetailsURL(personID id: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(personEndpoint)\(id)\(apiKey)\(languageAddon)\(Utilities.getLanguage())")
    }
    
//    GET Movie Poster URL
    static func getMovieImageURL(posterPath path: String, imageSize size: String) -> URL {
        return Utilities.stringToURL("\(imageURL)\(size)\(path)")
    }
    
    static func getGenres() -> URL {
        return Utilities.stringToURL("\(baseURL)\(genresEndpoint)\(apiKey)\(languageAddon)\(Utilities.getLanguage())")
    }
    
    static func getNowPlaying(pageNumber: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(nowplayingEndpoint)\(apiKey)\(languageAddon)\(Utilities.getLanguage())\(pageAddon)\(pageNumber)")
    }
    
    static func getUpcoming(pageNumber: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(upcomingEndpoint)\(apiKey)\(languageAddon)\(Utilities.getLanguage())\(pageAddon)\(pageNumber)")
    }
    
    static func getDiscover(pageNumber: Int, genreid: Int) -> URL {
        return Utilities.stringToURL("\(baseURL)\(discoverEndpoint)\(apiKey)\(languageAddon)\(Utilities.getLanguage())\(genresAddon)\(genreid)\(pageAddon)\(pageNumber)")
    }
    
}

//MARK: - Image Size Enums

enum PosterSize: String {
    case veryLow = "w92"
    case low = "w154"
    case medium = "w185"
    case high = "w342"
    case veryHigh = "w500"
    case ultra = "w780"
    case original = "original"
}

enum ProfileSize: String {
    case low = "w45"
    case medium = "w185"
    case high = "h632"
    case original = "original"
}
