//
//  AuthorizationViewController.swift
//  Chat
//
//  Created by Алиса Романова on 25.10.2022.
//

import SnapKit

protocol AuthorizationDisplayLogic: AnyObject {
    
}


class AuthorizationViewController: UIViewController {
    
    var interactor: AuthorizationBuisnessLogic?
    var router: AuthorizationRoutingLogic?
    
    //MARK: - Properties
    
    private let titleLabel = UILabel(title: "Chat", font: .systemFont(ofSize: 30))
    private let getStartedWithLabel = UILabel(title: "Get started with")
    private let orSignUpWithLabel = UILabel(title: "Or sign up with")
    private let aleradyOnboardLabel = UILabel(title: "Alerady onboard?")
    
    
    private let emailButton = UIButton(title: "Email", color: .black, titleColor: .white)
    private let loginButton = UIButton(title: "Login", color: .white, isShadow: true, titleColor: .red)
    private let googleButton = UIButton(title: "Google", color: .white, isShadow: true, titleColor: .black)

    private var stackView = UIStackView()
    

    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setupConstraints()
    }
}





//MARK: - Setup constraints

extension AuthorizationViewController {
    private func setupConstraints() {
        
        //Views
        
        let googleView = UIView(label: getStartedWithLabel, button: googleButton)
        let emailView = UIView(label: orSignUpWithLabel, button: emailButton)
        let loginView = UIView(label: aleradyOnboardLabel, button: loginButton)
        
        //titleLabel
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(160)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(158)
        }
        
        //stackView
        
        stackView = UIStackView(arrangedSubviews: [googleView, emailView, loginView])
        
        stackView.spacing = 40
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).inset(160)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)

        }
    }
}

//MARK: - AuthorizationDisplayLogic

extension AuthorizationViewController: AuthorizationDisplayLogic {
    
}
