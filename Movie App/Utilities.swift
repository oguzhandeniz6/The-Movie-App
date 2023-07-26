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
    
    static func changeViewController(currentVC: UIViewController, nextVC: UIViewController.Type) {
        let newVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: nextVC.self))
        currentVC.navigationController?.pushViewController(newVC, animated: true)
    }
    
}
