//
//  StringExtension.swift
//  Movie App
//
//  Created by oguzhan.deniz on 3.08.2023.
//

import Foundation

extension String {
    func localizeString(lang: String) -> String {
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj"), let bundle = Bundle(path: path) {
            return NSLocalizedString(self, bundle: bundle, comment: "")
        }
        return self
    }
    
    func percentEncode() -> String{
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? self
    }
}
