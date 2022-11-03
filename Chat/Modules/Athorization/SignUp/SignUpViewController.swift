//
//  SignUpViewController.swift
//  Chat
//
//  Created by Алиса Романова on 27.10.2022.
//

import UIKit

protocol SignUpDisplayLogic: AnyObject {
    
}


final class SignUpViewController: UIViewController {
    
    var router: SignUpRoutingLogic?
    var interactor: SignUpBuisnessLogic?
    
    //MARK: - Properties
    
    //Title
    private let titleLabel = UILabel(title: "Good to see you!", font: .systemFont(ofSize: 30))
    
    //Labels
    private let emailLabel = UILabel(title: "Email")
    private let passwordLabel = UILabel(title: "Password")
    private let confirmPasswordLabel = UILabel(title: "Confirm password")
    
    //TextFields
    private let emailTextField = UITextField(placeholder: "yourmail@mail.ru", textColor: .gray)
    private let passwordTestField = UITextField(placeholder: "1223445", textColor: .gray)
    private let confirmPasswordTextField = UITextField(placeholder: "1223445", textColor: .gray)

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
        
        setupSignUpButton()
        
        setupConstraints()
    }
    
    
    private func setupSignUpButton() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func signUpButtonTapped() {
        present((router?.pushToSetupProfileViewController())!, animated: true)
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





//MARK: - SignUpDisplayLogic

extension SignUpViewController: SignUpDisplayLogic {
    
}
