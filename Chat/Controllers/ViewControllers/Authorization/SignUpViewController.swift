//
//  SignUpViewController.swift
//  Chat
//
//  Created by Алиса Романова on 27.10.2022.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    private let service = AuthorizationService()
    
    //MARK: - Properties
    
    //flags
    private var isRegisterationSucssesful: Bool!
    
    //Title
    private let titleLabel = UILabel(title: "Good to see you!", font: .systemFont(ofSize: 30))
    
    //Labels
    private let emailLabel = UILabel(title: "Email")
    private let passwordLabel = UILabel(title: "Password")
    private let confirmPasswordLabel = UILabel(title: "Confirm password")
    
    //TextFields
    private let emailTextField = UITextField(line: true)
    private let passwordTestField = UITextField(line: true)
    private let confirmPasswordTextField = UITextField(line: true)

    //Buttons
    private let signUpButton = UIButton(title: "Sign Up", color: UIColor(named: "purple")!, titleColor: .white)
    
    //Views
    private lazy var emailView = UIView(label: emailLabel, textField: emailTextField)
    private lazy var passwordView = UIView(label: passwordLabel, textField: passwordTestField)
    private lazy var confirmPasswordView = UIView(label: confirmPasswordLabel, textField: confirmPasswordTextField)
    
    //StackViews
    private lazy var stackView = UIStackView(arrangedSubviews: [emailView, passwordView, confirmPasswordView, signUpButton], spacing: 45)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.liftUpView(amount: 100)
        
        setupSignUpButton()
        setupTestFieldsDelegates()
        
        setupConstraints()
    }
    
    //MARK: - setupTestFieldsDelegates
    
    private func setupTestFieldsDelegates() {
        emailTextField.delegate = self
        passwordTestField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    //MARK: - setupSignUpButton
    
    private func setupSignUpButton() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc signUpButtonTapped
    
    @objc private func signUpButtonTapped() {
        
        let email = emailTextField.text
        let password = passwordTestField.text
        let confirmPassword = confirmPasswordTextField.text
        
        service.registerUser(email: email!, password: password!, confirmPassword: confirmPassword!) {
            [weak self] result in
            
            switch result {
                
            case .success(let user):
                let view = SetupProfileViewController(email: user.email!, id: user.uid)
                view.modalPresentationStyle = .fullScreen
                
                self?.present(view, animated: true)
                
            case .failure(let error):
                self?.showErrorAlert(message: error.localizedDescription)
                
            }
        }
    }
}

//MARK: - Setup constraints

extension SignUpViewController {
    private func setupConstraints() {
        
        //titleLabel
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        //signUpButton
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        //stackView
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
            make.top.equalTo(titleLabel.snp.bottom).offset(130)
         
        }
    }
}

//MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
