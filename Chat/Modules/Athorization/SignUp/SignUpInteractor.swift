//
//  SignUpInteractor.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

protocol SignUpBuisnessLogic {
    func makeRequest(request: SignUpModels.ModelType.Request.RequestType)
}


final class SignUpInteractor: SignUpBuisnessLogic {
  
    var presenter: SignUpPresentationLogic?
    var worker: SignUpStorageLogic?
    var setupProfileInteractor: SetupProfileBuisnessLogic?
    
    func makeRequest(request: SignUpModels.ModelType.Request.RequestType) {
        switch request {
            
        case .requestRegistration(email: let email, password: let password):
            worker?.registerUser(email: email, password: password, completion: { result in
                switch result {
                    
                case .success(let user):
                    
                    self.presenter?.presentData(response: SignUpModels.ModelType.Response.ResponseType.registerationSucssesful)
                    self.setupProfileInteractor?.makeRequest(request: SetupProfileModels.ModelType.Request.RequestType.getUserData(id: user.uid, email: user.email!))

                case .failure(let error):
                    self.presenter?.presentData(response: SignUpModels.ModelType.Response.ResponseType.registerationFalure)
                    print("Error in SignUpInteractor:", error)
                }
            })
        }
    }
}
