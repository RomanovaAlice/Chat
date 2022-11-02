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
        let presenter = AuthorizationPrsenter()
        let view = AuthorizationViewController()
        let router = AuthorizationRouter()
        let worker = AuthorizationWorker()
        
        //connections
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.view = view
        
        view.interactor = interactor
        view.router = router
        
        return view
    }
    
    //MARK: - Login Module
    
    func createLoginModule() -> UIViewController {
        let view = LoginViewController()
        let router = LoginRouter()
        
        //connections
        view.router = router
        
        return view
    }
    
    //MARK: - SignUp Module
    
    func createSignUpModule() -> UIViewController {
        let view = SignUpViewController()
        let router = SignUpRouter()
        
        //connections
        view.router = router
        
        return view
    }
    
    //MARK: - SetupProfile Module
    
    func createSetupProfileModule() -> UIViewController {
        let view = SetupProfileViewController()
        let router = SetupProfileRouter()
        
        //connections
        view.router = router
        
        return view 
    }
    
    //MARK: - Users, Chat, Profile Modules
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = TabBarController()
        
        tabBarController.modalPresentationStyle = .fullScreen
        
        return tabBarController
    }
}
