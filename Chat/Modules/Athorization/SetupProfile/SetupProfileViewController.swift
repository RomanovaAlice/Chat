//
//  SetupProfileViewController.swift
//  Chat
//
//  Created by Алиса Романова on 28.10.2022.
//

import SnapKit

final class SetupProfileViewController: UIViewController {
    
    var router: SetupProfileRoutingLogic?
    
    //MARK: - Properties
    
    //items
    private let items = ["Male", "Female"]
    
    //title
    private let titleLabel = UILabel(title: "Set up profile", font: .systemFont(ofSize: 30))
    
    //labels
    private let fullNameLabel = UILabel(title: "Full name", textAlignment: .left)
    private let aboutMeLabel = UILabel(title: "About me", textAlignment: .left)
    private let sexLabel = UILabel(title: "Sex", textAlignment: .left)
    
    //buttons
    private let goToChatsButton = UIButton(title: "Go to chats!", color: .black, titleColor: .white)
    private let addingButton = UIButton()
    
    //testFields
    private let fullNameTextField = UITextField(placeholder: "Bob Robinson")
    private let aboutMeTextField = UITextField(placeholder: "i can tell you a very funny joke")
    
    //imageView
    private let photoImageView = UIImageView()
    
    //segmentedControl
    private lazy var sexSegmentedControl = UISegmentedControl(items: items)
    
    //stackViews
    private lazy var fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel, fullNameTextField], spacing: 10)
    private lazy var aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeTextField], spacing: 10)
    private lazy var sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl], spacing: 20)
    
    private lazy var centerStackView = UIStackView(
        arrangedSubviews: [fullNameStackView, aboutMeStackView, sexStackView, goToChatsButton],
        spacing: 35)

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupAddingButton()
        setupSexSegmentedControl()
        setupPhotoImageVeiw()
        
        setuContsraints()
    }
    
    private func setupAddingButton() {
        addingButton.setImage(UIImage(named: "add"), for: .normal)
        addingButton.clipsToBounds = true
    }
    
    private func setupSexSegmentedControl() {
        sexSegmentedControl.selectedSegmentIndex = 1
    }

    private func setupPhotoImageVeiw() {
        photoImageView.layer.cornerRadius = 50
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.borderColor = UIColor.black.cgColor
        photoImageView.image = UIImage(named: "user")
        photoImageView.clipsToBounds = true
    }
}





//MARK: - Setup constraints

extension SetupProfileViewController {
    private func setuContsraints() {
        
        //titleLabel
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(160)
            make.centerX.equalToSuperview()
        }
        
        //photoImageView
        
        view.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(120)
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.height.width.equalTo(100)
        }
        
        //addingButton
        
        view.addSubview(addingButton)
        
        addingButton.snp.makeConstraints { make in
            make.top.equalTo(photoImageView).inset(40)
            make.left.equalTo(photoImageView.snp.right).offset(15)
            make.height.width.equalTo(30)
        }
        
        //goToChatsButton
        
        goToChatsButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        //centerStackVeiw
        
        view.addSubview(centerStackView)
        
        centerStackView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
        }
    }
}
