//
//  AssemblyLayer.swift
//  Chat
//
//  Created by Алиса Романова on 25.10.2022.
//

import UIKit

final class AssemblyLayer {
    
    static let shared = AssemblyLayer()
    
    //MARK: - Authorization Module
    
    func createAuthorizationModule() -> UIViewController {
        
        let interactor = AuthorizationInteractor()
        let presenter = AuthorizationPresenter()
        let view = AuthorizationViewController()
        let router = AuthorizationRouter()

        
        //connections
        interactor.presenter = presenter

        
        presenter.view = view
        
        view.interactor = interactor
        view.router = router
        
        return view
    }
    
    //MARK: - Login Module
    
    func createLoginModule() -> UIViewController {
        
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let view = LoginViewController()
        let router = LoginRouter()
        let worker = LoginWorker()
        
        //connections
        interactor.presenter = presenter
        
        interactor.worker = worker
        
        presenter.view = view
        
        view.interactor = interactor
        view.router = router
        
        return view
    }
    
    //MARK: - SignUp Module
    
    func createSignUpModule() -> UIViewController {
        
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter()
        let view = SignUpViewController()
        let router = SignUpRouter()
        let worker = SignUpWorker()
        
        //connections
        interactor.presenter = presenter
        
        interactor.worker = worker
        
        presenter.view = view
        
        view.interactor = interactor
        view.router = router
        
        return view
    }
    
    //MARK: - SetupProfile Module
    
    func createSetupProfileModule() -> UIViewController {
        
        let interactor = SetupProfileInteractor()
        let presenter = SetupProfilePresenter()
        let view = SetupProfileViewController()
        let router = SetupProfileRouter()
        
        view.modalPresentationStyle = .fullScreen
        
        //connections
        interactor.presenter = presenter
        
        presenter.view = view
        
        view.interactor = interactor
        view.router = router
        
        return view
    }
    
    //MARK: - Users Module
    
    func createUsersModule() -> UIViewController {
        
        let interactor = UsersInteractor()
        let presenter = UsersPresenter()
        let view = UsersViewController()
        let router = UsersRouter()
        
        //connections
        interactor.presenter = presenter
        
        presenter.view = view
        
        view.interactor = interactor
        view.router = router
        
        return view
    }
    
    //MARK: - Chat Module
    
    func createChatModule() -> UIViewController {
        
        let interactor = ChatInteractor()
        let presenter = ChatPresenter()
        let view = ChatViewController()
        let router = ChatRouter()
        
        //connections
        interactor.presenter = presenter
        
        presenter.view = view
        
        view.interactor = interactor
        view.router = router
        
        return view
    }
    
    //MARK: - Profile Module
    
    func createProfileModule() -> UIViewController {
        
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let view = ProfileViewController()
        let router = ProfileRouter()
        
        //connections
        interactor.presenter = presenter
        
        presenter.view = view
        
        view.interactor = interactor
        view.router = router
        
        return view
    }
    
    //MARK: - TabBarController
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = TabBarController()
        
        tabBarController.modalPresentationStyle = .fullScreen
        
        return tabBarController
    }
}
