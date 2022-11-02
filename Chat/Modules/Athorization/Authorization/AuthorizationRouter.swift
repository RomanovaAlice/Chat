//
//  AuthorizationRouter.swift
//  Chat
//
//  Created by Алиса Романова on 25.10.2022.
//

import UIKit

protocol AuthorizationRoutingLogic: AnyObject {
    func pushToLoginViewController() -> UIViewController
    func pushToSignUpViewController() -> UIViewController
}


final class AuthorizationRouter: AuthorizationRoutingLogic {
    
    
    func pushToLoginViewController() -> UIViewController {
        return AssemblyLayer.shared.createLoginModule()
    }
    
    func pushToSignUpViewController() -> UIViewController {
        return AssemblyLayer.shared.createSignUpModule()
    }
}
