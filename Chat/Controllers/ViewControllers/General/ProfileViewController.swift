//
//  ProfileViewController.swift
//  Chat
//
//  Created by Алиса Романова on 01.11.2022.
//

import SnapKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    //MARK: - Properties
    
    private let userData: Human
    
    private var service = FetchImageService()
    
    //imageView
    private var photoImageView = UIImageView()
    
    //labels
    private let usernameLabel = UILabel(title: "Username", textAlignment: .left, textColor: .gray)
    private let emailLabel = UILabel(title: "Email", textAlignment: .left, textColor: .gray)
    private let genderLabel = UILabel(title: "Gender", textAlignment: .left, textColor: .gray)
    private let aboutMeLabel = UILabel(title: "About me", textAlignment: .left, textColor: .gray)
    
    //textFields
    private let usernameTextField = UITextField(placeholder: "")
    private let emailTextField = UITextField(placeholder: "")
    private let genderTextField = UITextField(placeholder: "")
    private let aboutMeTextField = UITextField(placeholder: "")
    
    //button
    private let exitButton = UIButton(title: "Exit", cornerRadius: 25, titleColor: .systemGreen)
    
    //stackViews
    private lazy var usernameStackView = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField], spacing: 5)
    private lazy var emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], spacing: 5)
    private lazy var genderStackView = UIStackView(arrangedSubviews: [genderLabel, genderTextField], spacing: 5)
    private lazy var aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeTextField], spacing: 5)
    
    private lazy var centerStackView = UIStackView(arrangedSubviews: [usernameStackView, emailStackView, genderStackView, aboutMeStackView], spacing: 15)
    
    //MARK: - Init
    
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
        
        setupNavigationBar()
        self.liftUpView(amount: 130)

        setupPhotoImageView()
        setupTextFieldsDelegates()
        setupTextFieldsText()
        setupButtonTargets()
        
        setupConstraints()
    }

    //MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: exitButton)
        view.backgroundColor = .white
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
        
        //photoImageView
        
        view.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(150)
        }
 
        //centerStackView
        
        view.addSubview(centerStackView)
        
        centerStackView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(30)
        }
    }
}

//MARK: - UITextFieldDelegate

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
