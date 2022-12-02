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
    private let titleLabel = UILabel(title: "Log In", font: .systemFont(ofSize: 40, weight: .semibold), textColor: .white)
    
    //button
    private let loginButton = UIButton(title: "Login", color: UIColor(named: "blue"), titleColor: .white)
    
    //textFields
    private let emailTextField = UITextField(placeholder: "Email", keyboardType: .emailAddress)
    private let passwordTextField = UITextField(placeholder: "Password")
    
    //other
    private let backgroundView = UIView(backgroundColor: UIColor(named: "dark-pink")!, radius: 10)
    private let picture = UIImageView(image: UIImage(named: "5"))
    
    //stackView
    private lazy var loginStackView = UIStackView(arrangedSubviews: [titleLabel, emailTextField, passwordTextField, loginButton], spacing: 25)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "pink")
        self.setTapGesture(action: #selector(hideKeyboard))
        
        setupButtonsTargets()
        setupTextFieldsDelegates()
        
        setupConstraints()
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
        
        //backgroundView
        
        view.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.top.equalToSuperview().inset(40)
        }
        
        //loginStackView
        
        backgroundView.addSubview(loginStackView)
        
        loginStackView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(25)
        }
        
        //loginButton
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        //picture
        
        view.addSubview(picture)
        
        picture.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(15)
            make.width.height.equalTo(400)
        }
        
    }
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
