//
//  ChatCell.swift
//  Chat
//
//  Created by Алиса Романова on 29.10.2022.
//

import SnapKit

final class ChatCell: UICollectionViewCell {
    static let identifier = "ChatCell"
    
    //MARK: - Properties
    var avatarImageView = UIImageView()
    var userNameLabel = UILabel(font: .systemFont(ofSize: 17, weight: .semibold), textColor: .white)
    var lastMessageLabel = UILabel(textColor: .systemGray6, alpha: 0.7)
    
    private var bottomLine = UIView(backgroundColor: UIColor(named: "dark-pink")!)
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAvatarImageView()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupAvatarImageView
    
    private func setupAvatarImageView() {
        avatarImageView.layer.cornerRadius = 10
        avatarImageView.clipsToBounds = true
    }
}

//MARK: - Setup constraints

extension ChatCell {
    private func setupConstraints() {
        
        //bottomLine
        
        self.addSubview(bottomLine)
        
        bottomLine.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(85)
            make.height.equalTo(1)
        }
        
        //avatarImageView
        
        self.addSubview(avatarImageView)
        
        avatarImageView.snp.makeConstraints { make in
            make.centerY.left.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(80)
        }
        
        //userNameLabel
        
        self.addSubview(userNameLabel)
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView).inset(10)
            make.left.equalTo(avatarImageView.snp.right).offset(20)
        }
        
        //lastMessageLabel
        
        self.addSubview(lastMessageLabel)
        
        lastMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.left.equalTo(userNameLabel)
        }
    }
}
