//
//  AuthorizationPresenter.swift
//  Chat
//
//  Created by Алиса Романова on 25.10.2022.
//

import Foundation

protocol AuthorizationPresentationlogic {
    func presentData(response: AuthorizationModels.ModelType.Response.ResponseType)
}


final class AuthorizationPresenter: AuthorizationPresentationlogic {
    
    weak var view: AuthorizationDisplayLogic?
    
    func presentData(response: AuthorizationModels.ModelType.Response.ResponseType) {
        switch response {
            
        }
    }
}

