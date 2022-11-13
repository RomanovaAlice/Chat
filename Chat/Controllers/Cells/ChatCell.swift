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
    private let avatarImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let lastMessageLabel = UILabel()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSelfAppearance()
        
        setupAvatarImageView()
        setupUserNameLabel()
        setupLastMessageLabel()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup cell elements
    
    private func setupSelfAppearance() {
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "purple")?.cgColor
    }
    
    private func setupAvatarImageView() {
        avatarImageView.image = UIImage(named: "userMessage")
        avatarImageView.layer.borderColor = UIColor(named: "purple")?.cgColor
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.cornerRadius = 25
    }

    private func setupUserNameLabel() {
        userNameLabel.text = "Alex Smith"
        userNameLabel.font = .systemFont(ofSize: 17, weight: .medium)
    }
    
    private func setupLastMessageLabel() {
        lastMessageLabel.text = "How are you?"
        lastMessageLabel.alpha = 0.7
    }
}

//MARK: - Setup constraints

extension ChatCell {
    private func setupConstraints() {
        
        //avatarImageView
        
        self.addSubview(avatarImageView)
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(10)
            make.width.height.equalTo(50)
        }
        
        //userNameLabel
        
        self.addSubview(userNameLabel)
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalTo(avatarImageView.snp.right).offset(20)
        }
        
        //lastMessageLabel
        
        self.addSubview(lastMessageLabel)
        
        lastMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
            make.left.equalTo(userNameLabel)
        }
    }
}
