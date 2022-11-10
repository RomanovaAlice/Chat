//
//  UIAlertController + Extension.swift
//  Chat
//
//  Created by Алиса Романова on 09.11.2022.
//

import UIKit

extension UIAlertController {
    
    convenience init(title: String?, message: String?) {
        self.init(title: title, message: message, preferredStyle: preferredStyle)
        
        
    }
}
