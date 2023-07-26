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
    
}
