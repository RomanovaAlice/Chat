//
//  UsersCell.swift
//  Chat
//
//  Created by Алиса Романова on 29.10.2022.
//

import SnapKit

final class UsersCell: UICollectionViewCell {
    static let identifier = "UsersCell"
    
    //MARK: - Properties
    private let photoImageView = UIImageView()
    private let nameLabel = UILabel()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSelfAppearance()
        
        setupPhotoImageView()
        setupNameLabel()
        
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
        
        self.layer.shadowColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    private func setupPhotoImageView() {
        photoImageView.image = UIImage(named: "userMessage")
    }
    
    private func setupNameLabel() {
        nameLabel.text = "Alex Smith"
        nameLabel.font = .systemFont(ofSize: 20)
    }
}

//MARK: - Setup constraints

extension UsersCell {
    private func setupConstraints() {
        
        //photoImageView
        
        self.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        
        //nameLabel
        
        self.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(15)
        }
    }
}
