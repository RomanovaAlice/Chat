//
//  UILabel + Extension.swift
//  Chat
//
//  Created by Алиса Романова on 26.10.2022.
//

import UIKit

extension UILabel {
    
    convenience init(title: String = "",
                     font: UIFont? = nil,
                     textAlignment: NSTextAlignment = .center,
                     textColor: UIColor? = nil,
                     numberOfLines: Int = 0,
                     alpha: CGFloat = 1) {
        self.init()
        
        self.text = title
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.alpha = alpha
        
        if font != nil {
            self.font = font
        }
        if textColor != nil {
            self.textColor = textColor
        }
    }
}
