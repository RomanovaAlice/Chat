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
        
        self.backgroundColor = .white
        self.textColor = textColor
        self.font = .systemFont(ofSize: 20)
        
        let lineView = UIView()
        lineView.backgroundColor = .systemGray2
        self.addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(0.17)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
