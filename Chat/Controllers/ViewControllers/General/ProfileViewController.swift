//
//  ProfileViewController.swift
//  Chat
//
//  Created by Алиса Романова on 01.11.2022.
//

import SnapKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    private var service = FetchImageService()

    //MARK: - Properties
    
    //imageView
    private var photoImageView = UIImageView()
    private let picture = UIImageView(image: UIImage(named: "4"))
    
    //labels
    private let usernameLabel = UILabel(title: "Username", textAlignment: .left, textColor: .white)
    private let emailLabel = UILabel(title: "Email", textAlignment: .left, textColor: .white)
    private let genderLabel = UILabel(title: "Gender", textAlignment: .left, textColor: .white)
    private let aboutMeLabel = UILabel(title: "About me", textAlignment: .left, textColor: .white)
    
    //textFields
    private let usernameTextField = UITextField(custom: true)
    private let emailTextField = UITextField(custom: true)
    private let genderTextField = UITextField(custom: true)
    private let aboutMeTextField = UITextField(custom: true)
    
    //button
    private let exitButton = UIButton(title: "Exit", cornerRadius: 25, titleColor: .white)
    
    //views
    private let topBackgroundView = UIView(backgroundColor: UIColor(named: "dark-pink")!)
    private let bottomBackgroundView = UIView(backgroundColor: UIColor(named: "dark-pink")!, radius: 10)
    
    //stackViews
    private lazy var usernameStackView = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField], spacing: 5)
    private lazy var emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], spacing: 5)
    private lazy var genderStackView = UIStackView(arrangedSubviews: [genderLabel, genderTextField], spacing: 5)
    private lazy var aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeTextField], spacing: 5)
    
    private lazy var centerStackView = UIStackView(arrangedSubviews: [usernameStackView, emailStackView, genderStackView, aboutMeStackView], spacing: 15)
    
    //MARK: - Init
    
    private let userData: Human
    
    init(userData: Human) {
        self.userData = userData
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "pink")
        
        setupNavigationBar()
        setupPhotoImageView()
        setupTextFieldsDelegates()
        setupTextFieldsText()
        setupButtonTargets()
        
        setupConstraints()
    }

    //MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: exitButton)
    }
    
    //MARK: - setupTextFieldsDelegates
    
    private func setupTextFieldsDelegates() {
        usernameTextField.delegate = self
        emailTextField.delegate = self
        genderTextField.delegate = self
        aboutMeTextField.delegate = self
    }
    
    //MARK: - setupTextFieldsText
    
    private func setupTextFieldsText() {
        usernameTextField.text = userData.username
        emailTextField.text = userData.email
        genderTextField.text = userData.sex
        aboutMeTextField.text = userData.description
    }
    
    //MARK: - setupButtonTargets
    
    private func setupButtonTargets() {
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - setupPhotoImageView
    
    private func setupPhotoImageView() {
        service.fetchImage(URLString: userData.avatar, imageView: &photoImageView)
        photoImageView.layer.cornerRadius = 10
        photoImageView.clipsToBounds = true
    }
    
    //MARK: - @objc setupNavigationBar
    
    @objc private func exitButtonTapped() {
        do {
            try Auth.auth().signOut()
            UIApplication.shared.keyWindow?.rootViewController = AuthorizationViewController()
        } catch {
            print("Error signing out: \(error)")
        }
    }
}

//MARK: - Setup constraints

extension ProfileViewController {
    private func setupConstraints() {
        
        //topBackgroundView
        
        view.addSubview(topBackgroundView)
        
        topBackgroundView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(170)
        }
        
        //photoImageView
        
        view.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(110)
            make.height.equalTo(200)
            make.width.equalTo(150)
        }
        
        //bottomBackgroundView
        
        view.addSubview(bottomBackgroundView)
        
        bottomBackgroundView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(photoImageView.snp.bottom).offset(30)
        }
        
        //picture
        
        view.addSubview(picture)
        
        picture.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.bottom.equalTo(photoImageView.snp.top).inset(25)
            make.centerX.equalToSuperview()
        }
    
        //centerStackView
        
        bottomBackgroundView.addSubview(centerStackView)
        
        centerStackView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}

//MARK: - UITextFieldDelegate

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
