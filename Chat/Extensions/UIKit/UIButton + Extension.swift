//
//  UIButton + Extension.swift
//  Chat
//
//  Created by Алиса Романова on 26.10.2022.
//

import UIKit

extension UIButton {
    
    convenience init(title: String,
                     color: UIColor? = .clear,
                     cornerRadius: CGFloat = 10,
                     titleColor: UIColor) {
        
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.layer.cornerRadius = cornerRadius
        self.setTitleColor(titleColor, for: .normal)
    }
    
    convenience init(title: String, color: UIColor) {
        self.init()
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(color, for: .normal)
    }
}
