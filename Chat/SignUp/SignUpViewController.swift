//
//  SignUpViewController.swift
//  Chat
//
//  Created by Алиса Романова on 27.10.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: - Properties
    
    //Title
    private let titleLabel = UILabel(title: "Good to see you!", font: .systemFont(ofSize: 30))
    
    //Labels
    private let emailLabel = UILabel(title: "Email")
    private let passwordLabel = UILabel(title: "Password")
    private let confirmPasswordLabel = UILabel(title: "Confirm password")
    
    //TextFields
    private let emailTextField = UITextField(placeholder: "youremail@mail.ru")
    private let passwordTestField = UITextField(placeholder: "1223445")
    private let confirmPasswordTextField = UITextField(placeholder: "1223445")

    //Buttons
    private let signUpButton = UIButton(title: "Sign Up", color: .black, titleColor: .white)
    
    //Views
    private lazy var emailView = UIView(label: emailLabel, textField: emailTextField)
    private lazy var passwordView = UIView(label: passwordLabel, textField: passwordTestField)
    private lazy var confirmPasswordView = UIView(label: confirmPasswordLabel, textField: confirmPasswordTextField)
    
    //StackView
    private lazy var stackView = UIStackView(arrangedSubviews: [emailView, passwordView, confirmPasswordView, signUpButton],
                                             spacing: 45)
    
    //Bottom elements
    private let alreadyOnboardLabel = UILabel(title: "Already onboard?", textAlignment: .left)
    private let loginButton = UIButton(title: "Login", color: .red)
    
    private lazy var bottomStrackView = UIStackView(arrangedSubviews: [alreadyOnboardLabel, loginButton],
                                                    spacing: 10,
                                                    axis: .horizontal)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupConstraints()
    }
}





//MARK: - Setup constraints

extension SignUpViewController {
    private func setupConstraints() {
        
        //titleLabel
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(160)
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
        
        //bottomStackView
        
        view.addSubview(bottomStrackView)
        
        bottomStrackView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(40)
            make.right.equalToSuperview().inset(150)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
