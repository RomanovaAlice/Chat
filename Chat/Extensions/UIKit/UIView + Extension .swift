//
//  UIView + Extension .swift
//  Chat
//
//  Created by Алиса Романова on 26.10.2022.
//

import SnapKit

extension UIView {
    
    convenience init(label: UILabel, button: UIButton) {
        self.init()
        
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        self.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(label.snp.right).offset(10)
            
        }
    }
    
    convenience init(label: UILabel, textField: UITextField) {
        self.init()
        
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        self.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(35)
        }
        
        self.snp.makeConstraints { make in
            make.bottom.equalTo(textField)
        }
    }
    
    convenience init(backgroundColor: UIColor, radius: CGFloat = 0) {
        self.init()
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = radius
    }
}
