//
//  LoginRouter.swift
//  Chat
//
//  Created by Алиса Романова on 02.11.2022.
//

import UIKit

protocol LoginRoutingLogic: AnyObject {
    func pushToSignUpViewController() -> UIViewController
    func pushToTabBarController() -> UITabBarController 
}


final class LoginRouter: LoginRoutingLogic {
    
    
    func pushToSignUpViewController() -> UIViewController {
        return AssemblyLayer.shared.createSignUpModule()
    }
    
    func pushToTabBarController() -> UITabBarController {
        return AssemblyLayer.shared.createTabBarController()
    }
}
