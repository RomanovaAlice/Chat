//
//  UILabel + Extension.swift
//  Chat
//
//  Created by Алиса Романова on 26.10.2022.
//

import UIKit


extension UILabel {
    
    convenience init(title: String, font: UIFont? = nil ) {
        self.init()
        
        self.text = title
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        
        if font != nil {
            self.font = font
        }
    }
}
