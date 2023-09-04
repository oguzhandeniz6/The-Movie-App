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
    
//    Namespaces
    private static let movieNamespace: String = "/movie"
    private static let searchNamespace: String = "/search"
    private static let discoverNamespace: String = "/discover"
    private static let genresNamespace: String = "/genre"
    
//    Endpoints
    private static let popularEndpoint: String = "/popular"
    private static let topRatedEndpoint: String = "/top_rated"
    private static let movieEndpoint: String = "/movie"
    private static let personEndpoint: String = "/person"
    private static let nowPlayingEndpoint: String = "/now_playing"
    private static let upcomingEndpoint: String = "/upcoming"
    private static let listEndpoint: String = "/list"
    
//    Appended endpoints
    private static let creditsEndpoint: String = "credits"
    private static let recommendationsEndpoint: String = "recommendations"
    private static let movieCreditsEndpoint: String = "movie_credits"
    private static let reviewsEndpoint: String = "reviews"
    
//    Add-ons
    private static let appendToResponseAddon: String = "&append_to_response="
    private static let pageAddon: String = "&page="
    private static let queryAddon: String = "&query="
    private static let languageAddon: String = "&language="
    private static let genresAddon: String = "&with_genres="
    private static let voteAverageGteAddon: String = "&vote_average.gte="
    private static let voteAverageLteAddon: String = "&vote_average.lte="
    private static let releaseDateGteAddon: String = "&primary_release_date.gte="
    private static let releaseDateLteAddon: String = "&primary_release_date.lte="
    private static let sortByAddon: String = "&sort_by="
    
    
//MARK: - GET URL Functions
    
//    GET Popular Movies URL
    static func getPopularMoviesURL(pageNumber num: Int) -> URL {
        return String("\(baseURL)\(movieNamespace)\(popularEndpoint)\(apiKey)\(pageAddon)\(num)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
//    GET Top Rated Movies URL
        static func getTopRatedMoviesURL(pageNumber num: Int) -> URL {
            return String("\(baseURL)\(movieNamespace)\(topRatedEndpoint)\(apiKey)\(pageAddon)\(num)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
        }
    
//    GET Now Playing Movies URL
    static func getNowPlaying(pageNumber: Int) -> URL {
        return String("\(baseURL)\(movieNamespace)\(nowPlayingEndpoint)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())\(pageAddon)\(pageNumber)").toURL()
    }
    
//    GET Upcoming Movies URL
    static func getUpcoming(pageNumber: Int) -> URL {
        return String("\(baseURL)\(movieNamespace)\(upcomingEndpoint)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())\(pageAddon)\(pageNumber)").toURL()
    }
    
//    GET Search Movie URL
    static func getSearchMovieURL(searchKey key: String, pageNumber num: Int) -> URL {
        return String("\(baseURL)\(searchNamespace)\(movieEndpoint)\(apiKey)\(queryAddon)\(key)\(pageAddon)\(num)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
//    GET Search Actor URL
    static func getSearchPersonURL(searchKey key: String, pageNumber num: Int) -> URL {
        return String("\(baseURL)\(searchNamespace)\(personEndpoint)\(apiKey)\(queryAddon)\(key)\(pageAddon)\(num)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
//    GET Movie With Credits and Recommendations URL
    static func getMovieWithCreditsAndRecommendationsURL(movieID id: Int) -> URL {
        return String("\(baseURL)\(movieNamespace)/\(id)\(apiKey)\(appendToResponseAddon)\(creditsEndpoint),\(recommendationsEndpoint)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
//    GET Person Details URL
    static func getPersonDetailsWithMovieCreditsURL(personID id: Int) -> URL {
        return String("\(baseURL)\(personEndpoint)/\(id)\(apiKey)\(appendToResponseAddon)\(movieCreditsEndpoint)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
//    GET Movie Poster URL
    static func getMovieImageURL(posterPath path: String, imageSize size: String) -> URL {
        return String("\(imageURL)\(size)\(path)").toURL()
    }
    
//    GET All Genres URL
    static func getGenres() -> URL {
        return String("\(baseURL)\(genresNamespace)\(movieEndpoint)\(listEndpoint)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())").toURL()
    }
    
//    GET Movies with Genre URL
    static func getMoviesWithGenre(pageNumber: Int, genreid: Int) -> URL {
        return String("\(baseURL)\(discoverNamespace)\(movieEndpoint)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())\(genresAddon)\(genreid)\(pageAddon)\(pageNumber)").toURL()
    }
    
//    GET Movies with Filters URL
    static func getMoviesWithFilters(pageNumber: Int, callObject: DiscoverCallObject) -> URL {
        return String("\(baseURL)\(discoverNamespace)\(movieEndpoint)\(apiKey)\(languageAddon)\(LocalizationHelper.getLanguage())\(voteAverageGteAddon)\(callObject.minVote)\(voteAverageLteAddon)\(callObject.maxVote)\(releaseDateGteAddon)\(callObject.minYear)\(releaseDateLteAddon)\(callObject.maxYear)\(genresAddon)\(callObject.withGenres)\(pageAddon)\(pageNumber)").toURL()
    }
    
//    GET Movie Reviews URL
    static func getMovieReviews(movieId: Int, pageNumber: Int) -> URL{
        return String("\(baseURL)\(movieNamespace)/\(movieId)/\(reviewsEndpoint)\(apiKey)\(pageAddon)\(pageNumber)").toURL()
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
