//
//  LoginInteractor.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

protocol LoginBuisnessLogic {
    func makeRequest(request: LoginModels.ModelType.Request.RequestType)
}


final class LoginInteractor: LoginBuisnessLogic {
  
    var presenter: LoginPresentationLogic?
    var worker: LoginStorageLogic?
    
    
    func makeRequest(request: LoginModels.ModelType.Request.RequestType) {
        switch request {
            
        case .requestLogin(email: let email, password: let password):
            
            worker?.loginUser(email: email, password: password, completion: { [weak self] result in
                switch result {
                    
                case .success(_):
                    self?.presenter?.presentData(response: LoginModels.ModelType.Response.ResponseType.loginSucssesful)
                    
                case .failure(let error):
                    self?.presenter?.presentData(response: LoginModels.ModelType.Response.ResponseType.loginFalure)
                    print("Error in LoginInteractor:", error)
                }
            })
        }
    }
}
