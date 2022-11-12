//
//  ProfileRouter.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import UIKit

protocol ProfileRoutingLogic {
    func pushToAuthorizationViewController() -> UIViewController
}


final class ProfileRouter: ProfileRoutingLogic {
    
    func pushToAuthorizationViewController() -> UIViewController {
        return AssemblyLayer.shared.createAuthorizationModule()
    }
}
