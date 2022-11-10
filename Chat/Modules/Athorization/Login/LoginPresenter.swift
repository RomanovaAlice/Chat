//
//  LoginPresenter.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

protocol LoginPresentationLogic {
    func presentData(response: LoginModels.ModelType.Response.ResponseType)
}


final class LoginPresenter: LoginPresentationLogic {

  weak var view: LoginDisplayLogic?
    
    func presentData(response: LoginModels.ModelType.Response.ResponseType) {
        switch response {
            
        case .loginSucssesful:
            view?.displayData(data: LoginModels.ModelType.ViewModel.ViewModelType.loginSucssesful)
            
        case .loginFalure:
            view?.displayData(data: LoginModels.ModelType.ViewModel.ViewModelType.loginFalure)
        }
    }
}
