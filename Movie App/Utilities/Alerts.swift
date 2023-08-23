//
//  Alerts.swift
//  Movie App
//
//  Created by oguzhan.deniz on 23.08.2023.
//

import Foundation
import UIKit

class Alerts {
    
    static func createAlertWithAction(title: String, message: String = "", actionTitle: String = LocalizationHelper.okName.localizeString(), controllerStyle: UIAlertController.Style = .alert, actionStyle: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: controllerStyle)
        alert.addAction(UIAlertAction(title: actionTitle, style: actionStyle, handler: handler))
        
        return alert
    }
}
