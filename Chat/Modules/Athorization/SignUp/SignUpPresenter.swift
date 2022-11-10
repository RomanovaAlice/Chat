//
//  SignUpPresenter.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

protocol SignUpPresentationLogic {
    func presentData(response: SignUpModels.ModelType.Response.ResponseType)
}


final class SignUpPresenter: SignUpPresentationLogic {

  weak var view: SignUpDisplayLogic?
    
    func presentData(response: SignUpModels.ModelType.Response.ResponseType) {
        switch response {
            
        case .registerationSucssesful:
            view?.displayData(data: SignUpModels.ModelType.ViewModel.ViewModelType.registerationSucssesful)
            
        case .registerationFalure:
            view?.displayData(data: SignUpModels.ModelType.ViewModel.ViewModelType.registerationFalure)
        }
    }
}
