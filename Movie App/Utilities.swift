//
//  Utilities.swift
//  Movie App
//
//  Created by oguzhan.deniz on 25.07.2023.
//

import Foundation
import UIKit

class Utilities {
    
    static func stringToURL(_ str: String) -> URL {
        if let url = URL(string: str.replacingOccurrences(of: " ", with: "+")) {
            return url
        } else {
            return URL(string: "www.google.com")!
        }
    }
    
    static func genresArrayToStr(gen: [Genre]?) -> String{
        guard var safeGen = gen else {
            return ""
        }
        if safeGen.count > 0 {
            var returnStr: String = safeGen[0].name ?? ""
            safeGen.removeFirst()
            
            for item in safeGen {
                returnStr += ", \(item.name ?? "")"
            }
            
            return returnStr
        } else {
            return ""
        }
    }
    
    static func dateFormatChanger(str: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        
        guard let date = dateFormatter.date(from: str) else {
            dateFormatter.dateFormat = "MMM d, yy"
            return dateFormatter.string(from: Date(timeIntervalSince1970: 0))
        }
        
        dateFormatter.dateFormat = "MMM d, yy"
        
        return dateFormatter.string(from: date)
    }
    
    static func moneyFormatChanger(amount: Int) -> String {
        // BURAYLA UĞRAŞILACAK
        
//        let currencyFormatter = NumberFormatter()
//        currencyFormatter.usesGroupingSeparator = true
//        currencyFormatter.numberStyle = .currency
//        // localize to your grouping and decimal separator
//        currencyFormatter.locale = Locale.current
//
//        guard let priceString = currencyFormatter.string(from: amount as NSNumber) else {
//            return "$\(amount)"
//        }
        
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
//        numberFormatter.groupingSeparator = ","
//        numberFormatter.groupingSize = 3
//
//        guard let formattedString = numberFormatter.string(from: NSNumber(value: amount)) else {
//            return "$\(amount)"
//        }
        
//        switch "\(amount)".count {
//        case 4..<7:
//            return "$\(String(format: "%.3f", amount)) K"
//        case 7..<10:
//            return "$\(String(format: "%.6f", amount)) M"
//        case 10...:
//            return "$\(String(format: "%.9f", amount)) B"
//        default:
//            return "$\(String(amount))"
//        }
        
        
//        return priceString
        
        return "$\(amount)"
    }
    
}
