//
//  LoginViewController.swift
//  Chat
//
//  Created by Алиса Романова on 27.10.2022.
//

import SnapKit

final class LoginViewController: UIViewController {
    
    private let service = AuthorizationService()
    
    //MARK: - Properties

    //title
    private let titleLabel = UILabel(title: "Welcome back!", font: .systemFont(ofSize: 30))
    
    //labels
    private let emailLabel = UILabel(title: "Email", textAlignment: .left)
    private let paddwordLabel = UILabel(title: "Password", textAlignment: .left)
    
    //button
    private let loginButton = UIButton(title: "Login", color: UIColor(named: "purple")!, titleColor: .white)
    
    //textFields
    private let emailTextField = UITextField(line: true)
    private let passwordTextField = UITextField(line: true)
    
    //stackViews
    private lazy var emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], spacing: 20)
    private lazy var passwordStackView = UIStackView(arrangedSubviews: [paddwordLabel, passwordTextField], spacing: 20)
    
    private lazy var centerStackView = UIStackView(arrangedSubviews: [emailStackView, passwordStackView, loginButton], spacing: 70)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        self.liftUpView(amount: 60)
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
    
    //MARK: - @objc "loginButtonTapped"
    
    @objc private func loginButtonTapped() {
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        service.loginUser(email: email!, password: password!) { [weak self] result in
            switch result {
                
            case .success(let user):
                self?.service.getUserData(user: user) { result in
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
            make.top.equalToSuperview().inset(160)
        }
        
        //loginButton
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        //centerStackVeiw
        
        view.addSubview(centerStackView)
        
        centerStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(100)
            make.left.right.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
        }
    }
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
