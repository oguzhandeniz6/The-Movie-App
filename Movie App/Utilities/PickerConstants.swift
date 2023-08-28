//
//  PickerConstants.swift
//  Movie App
//
//  Created by oguzhan.deniz on 28.08.2023.
//

import Foundation

class PickerConstants {
    
    private static let minVote: Float = 0.0
    private static let maxVote: Float = 10.0
    private static let minYear: Int = 1870
    private static let maxYear: Int = 2035
    private static let defaultSort: SortBy = .popularityDesc
    
    static func setVotePickerFilter(value: Int) -> Float {
        return Float(value) / 2.0
    }
    
    static func setYearPickerFilter(value: Int) -> Int {
        return value + minYear
    }
    
    static func getVotePickerSource() -> [String] {
        var returnArray: [String] = []
        var i = 0.0
        
        while i <= 10 {
            returnArray.append(String(i))
            i += 0.5
        }
        
        return returnArray
    }
    
    static func getYearPickerSource() -> [String] {
        var returnArray: [String] = []
        
        for i in 1870...2035 {
            returnArray.append(String(i))
        }
        
        return returnArray
    }
    
    static func getSortPickerSource() -> [String] {
        
        return [
            LocalizationHelper.popularityAscName.localizeString(),
            LocalizationHelper.popularityDescName.localizeString(),
            LocalizationHelper.revenueAscName.localizeString(),
            LocalizationHelper.revenueDescName.localizeString(),
            LocalizationHelper.releaseDateAscName.localizeString(),
            LocalizationHelper.releaseDateDescName.localizeString(),
            LocalizationHelper.voteAvgAscName.localizeString(),
            LocalizationHelper.voteAvgDescName.localizeString(),
            LocalizationHelper.voteCountAscName.localizeString(),
            LocalizationHelper.voteCountDescName.localizeString()
        ]
    }
    
    static func getSortTypeFromString(sortTypeStr: String) -> SortBy {
        
        switch sortTypeStr {
            
        case LocalizationHelper.popularityAscName.localizeString():
            return .popularityAsc
        case LocalizationHelper.popularityDescName.localizeString():
            return .popularityDesc
        case LocalizationHelper.revenueAscName.localizeString():
            return .revenueAsc
        case LocalizationHelper.revenueDescName.localizeString():
            return .revenueDesc
        case LocalizationHelper.releaseDateAscName.localizeString():
            return .releaseDateAsc
        case LocalizationHelper.releaseDateDescName.localizeString():
            return .releaseDateDesc
        case LocalizationHelper.voteAvgAscName.localizeString():
            return .voteAvgAsc
        case LocalizationHelper.voteAvgDescName.localizeString():
            return .voteAvgDesc
        case LocalizationHelper.voteCountAscName.localizeString():
            return .voteCountAsc
        case LocalizationHelper.voteCountDescName.localizeString():
            return .voteCountDesc
        default:
            return PickerConstants.defaultSort
        }
    }
}

enum SortBy {
    
    case popularityAsc
    case popularityDesc
    case revenueAsc
    case revenueDesc
    case releaseDateAsc
    case releaseDateDesc
    case voteAvgAsc
    case voteAvgDesc
    case voteCountAsc
    case voteCountDesc
}
