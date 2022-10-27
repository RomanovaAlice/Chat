//
//  LoginViewController.swift
//  Chat
//
//  Created by Алиса Романова on 27.10.2022.
//

import SnapKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    //title
    private let titleLabel = UILabel(title: "Welcome back!", font: .systemFont(ofSize: 30))
    
    //labels
    private let loginWithLabel = UILabel(title: "Login with", textAlignment: .left)
    private let orLabel = UILabel(title: "or", textAlignment: .left)
    private let emailLabel = UILabel(title: "Email", textAlignment: .left)
    private let paddwordLabel = UILabel(title: "Password", textAlignment: .left)
    private let needAnAccountLabel = UILabel(title: "Need an account?", textAlignment: .left)
    
    //button
    private let googleButton = UIButton(title: "Google", color: .white, isShadow: true, titleColor: .black)
    private let loginButton = UIButton(title: "Login", color: .black, titleColor: .white)
    private let signUpButton = UIButton(title: "Sign Up", color: .white, titleColor: .red)
    
    //textFields
    private let emailTestField = UITextField(placeholder: "yourmail@mail.ru")
    private let passwordTestField = UITextField(placeholder: "1223445")
    
    //stackViews
    private lazy var loginStackView = UIStackView(arrangedSubviews: [loginWithLabel, googleButton], spacing: 10)
    private lazy var emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTestField], spacing: 10)
    private lazy var passwordStackView = UIStackView(arrangedSubviews: [paddwordLabel, passwordTestField], spacing: 10)
    
    private lazy var centerStackView = UIStackView(
        arrangedSubviews: [loginStackView, orLabel, emailStackView,  passwordStackView, loginButton],
        spacing: 40)
    private lazy var bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, signUpButton],
                                                   spacing: 10, axis: .horizontal)

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupConstraints()
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
        
        //googleButton
        
        googleButton.snp.makeConstraints { make in
            make.height.equalTo(60)
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
        
        //bottomStack
        
        view.addSubview(bottomStackView)
        
        bottomStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(40)
            make.right.equalToSuperview().inset(150)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
