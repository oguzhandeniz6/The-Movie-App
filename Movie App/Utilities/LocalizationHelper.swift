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
    static let favoriteTabBarName: String = "favoriteTabBar"
    static let homepageTabBarName: String = "homepageTabBar"
    
//    Title Names
    static let nowPlayingName: String = "nowPlaying"
    static let upcomingName: String = "upcoming"
    static let movieHomepageName: String = "movieHomepage"

//    Other Names
    static let minuteName: String = "minute"
    
    
//    Functions
    static func getLanguage() -> String{
        if NSLocale.current.languageCode == "tr" {
            return "tr-TR"
        } else {
            return "en-US"
        }
    }
}
