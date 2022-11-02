//
//  UITextField + Extension .swift
//  Chat
//
//  Created by Алиса Романова on 27.10.2022.
//

import SnapKit


extension UITextField {
    
    convenience init(placeholder: String, textColor: UIColor = .black) {
        self.init()
        
        self.placeholder = placeholder
        self.backgroundColor = .white
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let lineView = UIView()
        lineView.backgroundColor = .systemGray2
        self.addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        lineView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(0.17)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    convenience init(line: Bool) {
        self.init()
        
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .systemFont(ofSize: 20)
        
        let lineView = UIView()
        lineView.backgroundColor = .systemGray2
        self.addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        lineView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(0.17)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
