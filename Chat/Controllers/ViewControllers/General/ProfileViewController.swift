//
//  ProfileViewController.swift
//  Chat
//
//  Created by Алиса Романова on 01.11.2022.
//

import SnapKit

class ProfileViewController: UIViewController {

    //MARK: - Properties
    
    //imageView
    private let photoImageView = UIImageView()
    
    //labels
    private let usernameLabel = UILabel(title: "Username", textAlignment: .left, textColor: .gray)
    private let emailLabel = UILabel(title: "Email", textAlignment: .left, textColor: .gray)
    private let genderLabel = UILabel(title: "Gender", textAlignment: .left, textColor: .gray)
    private let aboutMeLabel = UILabel(title: "About me", textAlignment: .left, textColor: .gray)
    
    //textFields
    private let usernameTextField = UITextField(line: true)
    private let emailTextField = UITextField(line: true)
    private let genderTextField = UITextField(line: true)
    private let aboutMeTextField = UITextField(line: true)
    
    //button
    private let editButton = UIButton(title: "Edit", color: UIColor(named: "purple")!, titleColor: .white)
    private let addNewPhotoButton = UIButton()
    private let exitButton = UIButton(title: "Exit", cornerRadius: 25, titleColor: UIColor(named: "purple")!)
    
    //stackViews
    private lazy var usernameStackView = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField], spacing: 5)
    private lazy var emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], spacing: 5)
    private lazy var genderStackView = UIStackView(arrangedSubviews: [genderLabel, genderTextField], spacing: 5)
    private lazy var aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeTextField], spacing: 5)
    
    private lazy var centerStackView = UIStackView(arrangedSubviews: [usernameStackView, emailStackView, genderStackView, aboutMeStackView, editButton], spacing: 30)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()

        setupPhotoImageView()
        setupAddNewPhotoButton()
        
        setupUsernameTextField()
        setupEmailTextField()
        setupGenderTextField()
        setupAboutMeTextField()
        setupExitButton()
        
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: exitButton)
        view.backgroundColor = .white
    }
    
    private func setupPhotoImageView() {
        photoImageView.image = UIImage(named: "userMessage")
        photoImageView.layer.cornerRadius = 75
        photoImageView.layer.borderColor = UIColor(named: "purple")?.cgColor
        photoImageView.layer.borderWidth = 1
    }
    
    private func setupAddNewPhotoButton() {
        addNewPhotoButton.setImage(UIImage(named: "add"), for: .normal)
        addNewPhotoButton.clipsToBounds = true
        addNewPhotoButton.isHidden = true
    }
    
    private func setupUsernameTextField() {
        usernameTextField.delegate = self
        usernameTextField.text = "Alex Smith"
    }
    
    private func setupEmailTextField() {
        emailTextField.delegate = self
        emailTextField.text = "yourmail@mail.ru"
    }
    
    private func setupGenderTextField() {
        genderTextField.delegate = self
        genderTextField.text = "Male"
    }
    
    private func setupAboutMeTextField() {
        aboutMeTextField.delegate = self
        aboutMeTextField.text = "i can tell you a very funny joke"
    }
    
    private func setupExitButton() {
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    @objc private func exitButtonTapped() {
        present(AuthorizationViewController(), animated: true)
    }
}





//MARK: - Setup constraints

extension ProfileViewController {
    private func setupConstraints() {
        
        //photoImageView
        
        view.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(150)
        }
        
        //addNewPhotoButton
        
        view.addSubview(addNewPhotoButton)
        
        addNewPhotoButton.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(-10)
            make.top.equalTo(photoImageView).inset(120)
        }
        
        //editButton
        
        editButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        //centerStackView
        
        view.addSubview(centerStackView)
        
        centerStackView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(70)
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
