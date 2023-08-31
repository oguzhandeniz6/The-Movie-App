//
//  LocalizationHelper.swift
//  Movie App
//
//  Created by oguzhan.deniz on 14.08.2023.
//

import Foundation

class LocalizationHelper {
    
//    Tab Bar Names
    static let popularTabBarName: String = "popularTabBar"
    static let searchTabBarName: String = "searchTabBar"
    static let favoriteTabBarName: String = "favoriteTabBar".localizeString()
//    buraya taşınabilir
//    var ve computed property incele
    static let homepageTabBarName: String = "homepageTabBar"
    
//    Title Names
    static let nowPlayingName: String = "nowPlaying"
    static let upcomingName: String = "upcoming"
    static let movieHomepageName: String = "movieHomepage"
    static let reviewPageName: String = "reviewPage"
    static let popularMoviesSegmentName: String = "popularMovies"
    static let topRatedMoviesSegmentName: String = "topRatedMovies"
    static let searchMovieSegmentName: String = "searchMovie"
    static let searchActorSegmentName: String = "searchPerson"
    static let discoverButtonName: String = "discover"
    static let voteLabelName: String = "voteLabel"
    static let yearLabelName: String = "yearLabel"
    static let sortLabelName: String = "sortLabel"
    
//    Alert Names
    
    static let sorryName: String = "sorry"
    static let noResultName: String = "noResult"
    static let noReviewName: String = "noReview"
    
//    Sort Names
    
    static let popularityAscName: String = "popularityAsc"
    static let popularityDescName: String = "popularityDesc"
    static let revenueAscName: String = "revenueAsc"
    static let revenueDescName: String = "revenueDesc"
    static let releaseDateAscName: String = "releaseDateAsc"
    static let releaseDateDescName: String = "releaseDateDesc"
    static let voteAvgAscName: String = "voteAvgAsc"
    static let voteAvgDescName: String = "voteAvgDesc"
    static let voteCountAscName: String = "voteCountAsc"
    static let voteCountDescName: String = "voteCountDesc"

//    Other Names
    static let backName: String = "back"
    static let minuteName: String = "minute"
    static let okName: String = "ok"
    
    
//    Functions
    static func getLanguage() -> String{
        if NSLocale.current.languageCode == "tr" {
            return "tr-TR"
        } else {
            return "en-US"
        }
    }
}
