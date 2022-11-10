//
//  AuthorizationInteractor.swift
//  Chat
//
//  Created by Алиса Романова on 25.10.2022.
//

import Foundation

protocol AuthorizationBuisnessLogic {
    func makeRequest(request: AuthorizationModels.ModelType.Request.RequestType)
}


final class AuthorizationInteractor: AuthorizationBuisnessLogic {
    
    var presenter: AuthorizationPresentationlogic?
    
    func makeRequest(request: AuthorizationModels.ModelType.Request.RequestType) {
        switch request {
            
        }
    }
}
