//
//  AuthorizationViewController.swift
//  Chat
//
//  Created by Алиса Романова on 25.10.2022.
//

import SnapKit

final class AuthorizationViewController: UIViewController {
    
    //MARK: - Properties
    
    //labels
    private let titleLabel = UILabel(title: "Let's Get Strated", font: .systemFont(ofSize: 43), textColor: .white, numberOfLines: 0)
    private let aleradyOnboardLabel = UILabel(title: "Alerady onboard?", textAlignment: .left)
    
    //buttons
    private let signUpButton = UIButton(title: "Sign up", color: UIColor(named: "purple"), titleColor: .white)
    private let loginButton = UIButton(title: "Login", titleColor: UIColor(named: "purple")!)
    
    //other
    private let picture = UIImageView(image: UIImage(named: "6"))
    private lazy var loginView = UIView(label: aleradyOnboardLabel, button: loginButton)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "beige")
        setupButtons()
        setupConstraints()
    }
    
    //MARK: - @objc setupButtons
    
    private func setupButtons() {
        signUpButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc emailButtonTapped
    
    @objc private func emailButtonTapped() {
        present(SignUpViewController(), animated: true)
    }
    
    //MARK: - @objc loginButtonTapped
    
    @objc private func loginButtonTapped() {
        present(LoginViewController(), animated: true)
    }
}

//MARK: - Setup constraints

extension AuthorizationViewController {
    private func setupConstraints() {
        
        //titleLabel
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
        }
        
        //picture
        
        view.addSubview(picture)
        
        picture.snp.makeConstraints { make in
            make.height.width.equalTo(400)
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
        }
        
        //signUpButton
        
        view.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.right.equalToSuperview().inset(40)
            make.top.equalTo(picture.snp.bottom).offset(80)
        }
        
        //loginView
        
        view.addSubview(loginView)
        
        loginView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
        }
    }
}
