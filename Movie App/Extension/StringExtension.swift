//
//  StringExtension.swift
//  Movie App
//
//  Created by oguzhan.deniz on 3.08.2023.
//

import Foundation

extension String {
    
    func toURL() -> URL {
//        string extension olarak yaz - URLComponents
        if let url = URL(string: self.replacingOccurrences(of: " ", with: "+")) {
            return url
        } else {
            return URL(string: "www.google.com")!
        }
    }
    
    func localizeString() -> String {
        if let path = Bundle.main.path(forResource: NSLocale.current.languageCode ?? "en", ofType: "lproj"), let bundle = Bundle(path: path) {
            return NSLocalizedString(self, bundle: bundle, comment: "")
        }
        return self
    }
    
    func percentEncode() -> String{
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? self
    }
}
