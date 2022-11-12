//
//  AuthorizationViewController.swift
//  Chat
//
//  Created by Алиса Романова on 25.10.2022.
//

import SnapKit


protocol AuthorizationDisplayLogic: AnyObject {
    func displayData(data: AuthorizationModels.ModelType.ViewModel.ViewModelType)
}


final class AuthorizationViewController: UIViewController {
    
    var interactor: AuthorizationBuisnessLogic?
    var router: AuthorizationRoutingLogic?
    
    //MARK: - Properties
    
    private let titleLabel = UILabel(title: "Chat", font: .systemFont(ofSize: 50))
    private let getStartedWithLabel = UILabel(title: "Get started with")
    private let aleradyOnboardLabel = UILabel(title: "Alerady onboard?")
    
    private let emailButton = UIButton(title: "Email", color: UIColor(named: "purple")!, titleColor: .white)
    private let loginButton = UIButton(title: "Login", color: .white, isShadow: true, titleColor: UIColor(named: "purple")!)


    private lazy var emailView = UIView(label: getStartedWithLabel, button: emailButton)
    private lazy var loginView = UIView(label: aleradyOnboardLabel, button: loginButton)
    
    private lazy var stackView = UIStackView(arrangedSubviews: [emailView, loginView], spacing: 60)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setupButtons()

        setupConstraints()
    }
    
    private func setupButtons() {
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func emailButtonTapped() {
        present((router?.pushToSignUpViewController())!, animated: true)
    }
    
    @objc private func loginButtonTapped() {
        present((router?.pushToLoginViewController())!, animated: true)
    }

}





//MARK: - Setup constraints

extension AuthorizationViewController {
    private func setupConstraints() {
        
        //titleLabel
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(160)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(158)
        }
        
        //stackView
        
        view.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).inset(200)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
        }
    }
}

//MARK: - AuthorizationDisplayLogic

extension AuthorizationViewController: AuthorizationDisplayLogic {
    func displayData(data: AuthorizationModels.ModelType.ViewModel.ViewModelType) {
        switch data {
            
        }
    }
}
