//
//  UIButton + Extension.swift
//  Chat
//
//  Created by Алиса Романова on 26.10.2022.
//

import UIKit

extension UIButton {
    
    convenience init(title: String,
                     color: UIColor,
                     isShadow: Bool = false,
                     cornerRadius: CGFloat = 5,
                     titleColor: UIColor) {
        
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.layer.cornerRadius = cornerRadius
        self.setTitleColor(titleColor, for: .normal)
    
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
}
