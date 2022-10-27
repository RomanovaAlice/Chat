//
//  UIStackView + Extension.swift
//  Chat
//
//  Created by Алиса Романова on 27.10.2022.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], spacing: CGFloat, axis: NSLayoutConstraint.Axis = .vertical) {
        
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = spacing
        self.axis = axis
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
