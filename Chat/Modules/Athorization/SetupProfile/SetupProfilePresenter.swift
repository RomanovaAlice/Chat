//
//  SetupProfilePresenter.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

protocol SetupProfilePresentationLogic {
    func presentData(response: SetupProfileModels.ModelType.Response.ResponseType)
}


final class SetupProfilePresenter: SetupProfilePresentationLogic {

  weak var view: SetupProfileDisplayLogic?
    
    func presentData(response: SetupProfileModels.ModelType.Response.ResponseType) {
        switch response {
            
        }
    }
}
