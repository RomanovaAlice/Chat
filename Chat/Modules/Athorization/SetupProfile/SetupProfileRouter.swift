//
//  SetupProfileRouter.swift
//  Chat
//
//  Created by Алиса Романова on 02.11.2022.
//

import UIKit

protocol SetupProfileRoutingLogic: AnyObject {
    func pushToTabBarController() -> UITabBarController 
}


final class SetupProfileRouter: SetupProfileRoutingLogic {
    
    
    func pushToTabBarController() -> UITabBarController {
        return AssemblyLayer.shared.createTabBarController()
    }
}
