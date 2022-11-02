//
//  AuthorizationAssembly.swift
//  Chat
//
//  Created by Алиса Романова on 02.11.2022.
//

import UIKit

final class AuthorizationAssembly {
    
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
}
