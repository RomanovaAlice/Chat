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
    private let titleLabel = UILabel(title: "Sign Up", font: .systemFont(ofSize: 40, weight: .bold), textColor: .black)
    
    //TextFields
    private let emailTextField = UITextField(placeholder: "Email")
    private let passwordTestField = UITextField(placeholder: "Password")
    private let confirmPasswordTextField = UITextField(placeholder: "Comfirm password")

    //Buttons
    private let signUpButton = UIButton(title: "Sign Up", color: .systemGreen, titleColor: .white)
    
    //StackViews
    private lazy var stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTestField, confirmPasswordTextField], spacing: 20)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupSignUpButton()
        setupTestFieldsDelegates()
        createTapGesture()
        setKeyboardType()
        
        setupConstraints()
    }
    
    //MARK: - createTapGesture
    
    private func createTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - setKeyboardType
    
    private func setKeyboardType() {
        emailTextField.keyboardType = .emailAddress
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
    
    //MARK: - @objc "hideKeyboard"
    
    @objc private func hideKeyboard() {
        emailTextField.resignFirstResponder()
        passwordTestField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
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
            make.top.equalToSuperview().offset(40)
        }
        
        //signUpButton
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        //stackView
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
         
        }
        
        //signUpButton
        
        view.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(70)
        }
    }
}

//MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
