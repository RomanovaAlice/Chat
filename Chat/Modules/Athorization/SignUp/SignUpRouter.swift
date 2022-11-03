//
//  SignUpRouter.swift
//  Chat
//
//  Created by Алиса Романова on 02.11.2022.
//

import UIKit

protocol SignUpRoutingLogic: AnyObject {
    func pushToSetupProfileViewController() -> UIViewController
    func pushToLoginViewController() -> UIViewController 
}


final class SignUpRouter: SignUpRoutingLogic {
    
    
    func pushToSetupProfileViewController() -> UIViewController {
        return AssemblyLayer.shared.createSetupProfileModule()
    }
    
    func pushToLoginViewController() -> UIViewController {
        return AssemblyLayer.shared.createLoginModule()
    }
}
