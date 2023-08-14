//
//  LocalizationHelper.swift
//  Movie App
//
//  Created by oguzhan.deniz on 14.08.2023.
//

import Foundation

class LocalizationHelper {
    
    static func getLanguage() -> String{
        if NSLocale.current.languageCode == "tr" {
            return "tr-TR"
        } else {
            return "en-US"
        }
    }
}
