//
//  LoginViewController.swift
//  Chat
//
//  Created by Алиса Романова on 27.10.2022.
//

import SnapKit

final class LoginViewController: UIViewController {
    
    private let authorizationService = AuthorizationService()
    
    //MARK: - Properties

    //title
    private let titleLabel = UILabel(title: "Log In", font: .systemFont(ofSize: 40, weight: .bold), textColor: .black)
    
    //button
    private let loginButton = UIButton(title: "Login", color: .systemGreen, titleColor: .white)
    
    //textFields
    private let emailTextField = UITextField(placeholder: "Email")
    private let passwordTextField = UITextField(placeholder: "Password")
    
    private lazy var centerStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField], spacing: 20)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupButtonsTargets()
        setupTextFieldsDelegates()
        createTapGesture()
        setKeyboardType()
        
        setupConstraints()
    }
    
    //MARK: - setKeyboardType
    
    private func setKeyboardType() {
        emailTextField.keyboardType = .emailAddress
    }
    
    //MARK: - createTapGesture
    
    private func createTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - setupTestFieldsDelegates
    
    private func setupTextFieldsDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    //MARK: - setupButtons
    
    private func setupButtonsTargets() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc "hideKeyboard"
    
    @objc private func hideKeyboard() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    //MARK: - @objc "loginButtonTapped"
    
    @objc private func loginButtonTapped() {
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        authorizationService.loginUser(email: email!, password: password!) { [weak self] result in
            switch result {
                
            case .success(let user):
                FirestoreService.shared.getUserData(user: user) { result in
                    switch result {
                        
                    case .success(let user):
                        let tabBar = TabBarController(currentUser: user)
                        tabBar.modalPresentationStyle = .fullScreen
                        
                        self?.present(tabBar, animated: true)
                        
                    case .failure(let error):
                        self?.showErrorAlert(message: error.localizedDescription)
                    }
                }
            case .failure(let error):
                self?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
}

// MARK: - Setup constraints

extension LoginViewController {
    private func setupConstraints() {
        
        //titleLabel
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(40)
        }
        
        //centerStackVeiw
        
        view.addSubview(centerStackView)
        
        centerStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        
        //loginButton
        
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(70)
            make.left.right.equalToSuperview().inset(40)
        }
    }
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
