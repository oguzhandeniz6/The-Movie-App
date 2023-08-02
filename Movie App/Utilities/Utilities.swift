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
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: Date(timeIntervalSince1970: 0))
        }
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    static func moneyFormatChanger(amount: Int) -> String {
        
        var formattedPrice = Double(amount) / 1000.0
        
        if formattedPrice < 1 {
            return "$\(amount)"
        } else {
            formattedPrice /= 1000
            
            if formattedPrice < 1 {
                return "$\(String(format: "%.1f", formattedPrice * 1000)) K"
            } else {
                formattedPrice /= 1000
                
                if formattedPrice < 1 {
                    return "$\(String(format: "%.1f", formattedPrice * 1000)) M"
                } else {
                    formattedPrice /= 1000
                    
                    if formattedPrice < 1 {
                        return "$\(String(format: "%.1f", formattedPrice * 1000)) B"
                    } else {
                        return "$\(String(format: "%.1f", formattedPrice)) B"
                    }
                }
            }
        }
    }
    
}
