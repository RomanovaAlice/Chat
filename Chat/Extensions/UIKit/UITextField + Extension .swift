//
//  UITextField + Extension .swift
//  Chat
//
//  Created by Алиса Романова on 27.10.2022.
//

import SnapKit

extension UITextField {
    
    convenience init(line: Bool, textColor: UIColor = .gray) {
        self.init()
        
        self.textColor = textColor
        self.backgroundColor = .systemGray
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        
    }
    
    convenience init(placeholder: String, keyboardType: UIKeyboardType? = nil) {
        self.init()
        
        if keyboardType != nil {
            self.keyboardType = keyboardType!
        }
        
        self.placeholder = placeholder
        self.textColor = textColor
        self.textColor = .gray
        
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.systemGray5.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor(named: "gray")
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}
