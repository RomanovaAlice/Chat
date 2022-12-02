//
//  SignUpViewController.swift
//  Chat
//
//  Created by Алиса Романова on 27.10.2022.
//

import SnapKit

final class SignUpViewController: UIViewController {
    
    private let service = AuthorizationService()
    
    //MARK: - Properties
    
    //label
    private let titleLabel = UILabel(title: "Sign Up", font: .systemFont(ofSize: 40, weight: .bold), textColor: .white)
    
    //textFields
    private let emailTextField = UITextField(placeholder: "Email", keyboardType: .emailAddress)
    private let passwordTestField = UITextField(placeholder: "Password")
    private let confirmPasswordTextField = UITextField(placeholder: "Comfirm password")

    //buttons
    private let signUpButton = UIButton(title: "Sign Up", color: UIColor(named: "green"), titleColor: .white)
    
    //other
    private let backgroundView = UIView()
    private let picture = UIImageView(image: UIImage(named: "3"))
    
    //stackViews
    private lazy var signUpStackView = UIStackView(arrangedSubviews: [titleLabel, emailTextField, passwordTestField, confirmPasswordTextField, signUpButton], spacing: 20)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setTapGesture(action: #selector(hideKeyboard))
        
        setupViewsBackgroundColor()
        setupSignUpButton()
        setupTestFieldsDelegates()
        
        setupConstraints()
    }
    
    //MARK: - setupViewsBackgroundColor
    
    private func setupViewsBackgroundColor() {
        view.backgroundColor = UIColor(named: "pink")
        backgroundView.backgroundColor = UIColor(named: "dark-pink")
        backgroundView.layer.cornerRadius = 10
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
        
        //backgroundView
        
        view.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.center.equalToSuperview()
        }
        
        //loginStackView
        
        backgroundView.addSubview(signUpStackView)
        
        signUpStackView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(25)
        }
        
        //loginButton
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        //picture
        
        view.addSubview(picture)
        
        picture.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView.snp.top).offset(60)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(220)
        }

    }
}

//MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
