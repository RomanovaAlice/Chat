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
    private let backView = UIView()
    
    var photoImageView = UIImageView()
    var nameLabel = UILabel(title: "", font: .systemFont(ofSize: 18, weight: .semibold), textAlignment: .left, textColor: .black)
    var descriptionLabel = UILabel(title: "", textAlignment: .left, textColor: .gray)
    var genderLabel = UILabel(title: "", textAlignment: .left, textColor: .systemGreen)
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSelfAppearance()
        
        configureBackView()
        configureNameLabel()
        setupPhotoImageView()
        configureDescriptionLabel()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup cell elements
    
    private func configureBackView() {
        backView.backgroundColor = .systemGray6
        backView.layer.cornerRadius = 15
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.numberOfLines = 4
    }
    
    private func configureNameLabel() {
        nameLabel.numberOfLines = 1
    }
    
    private func setupSelfAppearance() {
        self.backgroundColor = .clear
    }
    
    private func setupPhotoImageView() {
        photoImageView.backgroundColor = .systemGray
        photoImageView.layer.cornerRadius = 15
        photoImageView.clipsToBounds = true
    }
}

//MARK: - Setup constraints

extension UsersCell {
    private func setupConstraints() {
        
        //backView
        
        self.addSubview(backView)
        
        backView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(17)
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(20)
            
        }
        
        //photoImageView
        
        self.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(150)
        }
        
        //nameLabel
        
        backView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).inset(-10)
            make.right.equalToSuperview().inset(2)
            make.top.equalToSuperview().offset(10)
        }
        
        //genderLabel
        
        backView.addSubview(genderLabel)
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-5)
            make.left.equalTo(nameLabel)
        }
        
        //descriptionLabel
        
        backView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).inset(-5)
            make.left.equalTo(nameLabel)
            make.right.equalToSuperview().inset(10)
        }
    }
}
