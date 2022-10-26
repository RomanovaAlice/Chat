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
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        self.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.equalTo(label).inset(40)
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
        
        self.snp.makeConstraints { make in
            make.bottom.equalTo(button)
        }
    }
}
