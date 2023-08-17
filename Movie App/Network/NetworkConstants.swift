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
    private static let searchMovieEndpoint: String = "/search/movie"
    private static let genresEndpoint: String = "/genre/movie/list"
    private static let discoverEndpoint: String = "/discover/movie"
    private static let nowplayingEndpoint: String = "/movie/now_playing"
    private static let upcomingEndpoint: String = "/movie/upcoming"
    private static let searchPersonEndpoint: String = "/search/person"
    
//    Complex endpoints
    private static let movieEndpoint: String = "/movie/"
    private static let personEndpoint: String = "/person/"
    private static let creditsEndpoint: String = "/credits"
    private static let recommendationsEndpoint: String = "/recommendations"
    private static let movieCreditsEndpoint: String = "/movie_credits"
    
//    Add-ons
    private static let pageAddon: String = "&page="
    private static let queryAddon: String = "&query="
    private static let languageAddon: String = "&language="
    private static let genresAddon: String = "&with_genres="
    
    
//MARK: - GET URL Functions
    
//    GET Popular Movies URL
    static func getPopularMoviesURL(pageNumber num: Int) -> URL {
        return String("\(baseURL)\(popularEndpoint)\(apiKey)\(pageAddon)\(num)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
//    GET Search Movie URL
    static func getSearchMovieURL(searchKey key: String, pageNumber num: Int) -> URL {
        return String("\(baseURL)\(searchMovieEndpoint)\(apiKey)\(queryAddon)\(key)\(pageAddon)\(num)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
//    GET Movie URL
    static func getMovieURL(movieID id: Int) -> URL {
        return String("\(baseURL)\(movieEndpoint)\(id)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
//    GET Movie Credits URL
    static func getMovieCreditsURL(movieID id: Int) -> URL {
        return String("\(baseURL)\(movieEndpoint)\(id)\(creditsEndpoint)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
//    GET Movie Recommendations URL
    static func getMovieRecommendationsURL(movieID id: Int) -> URL {
        return String("\(baseURL)\(movieEndpoint)\(id)\(recommendationsEndpoint)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
//    GET Person Details URL
    static func getPersonDetailsURL(personID id: Int) -> URL {
        return String("\(baseURL)\(personEndpoint)\(id)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
    //    GET Movie Credits of an Actor URL
        static func getMovieCredits(personID id: Int) -> URL {
            return String("\(baseURL)\(personEndpoint)\(id)\(movieCreditsEndpoint)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
//    GET Movie Poster URL
    static func getMovieImageURL(posterPath path: String, imageSize size: String) -> URL {
        return String("\(imageURL)\(size)\(path)").toURL()
    }
    
//    GET All Genres URL
    static func getGenres() -> URL {
        return String("\(baseURL)\(genresEndpoint)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
//    GET Now Playing Movies URL
    static func getNowPlaying(pageNumber: Int) -> URL {
        return String("\(baseURL)\(nowplayingEndpoint)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())\(pageAddon)\(pageNumber)").toURL()
    }
    
//    GET Upcoming Movies URL
    static func getUpcoming(pageNumber: Int) -> URL {
        return String("\(baseURL)\(upcomingEndpoint)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())\(pageAddon)\(pageNumber)").toURL()
    }
    
//    GET Movies with Genre URL
    static func getDiscover(pageNumber: Int, genreid: Int) -> URL {
        return String("\(baseURL)\(discoverEndpoint)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())\(genresAddon)\(genreid)\(pageAddon)\(pageNumber)").toURL()
    }
    
//    GET Search Actor URL
    static func getSearchPersonURL(searchKey key: String, pageNumber num: Int) -> URL {
        return String("\(baseURL)\(searchPersonEndpoint)\(apiKey)\(queryAddon)\(key)\(pageAddon)\(num)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
    
//    GET Movie Homepage URL
    static func getHomepage(homepage: String?) -> URL {
        return String(homepage ?? "").toURL()
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
