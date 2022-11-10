//
//  SetupProfileInteractor.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

protocol SetupProfileBuisnessLogic {
    func makeRequest(request: SetupProfileModels.ModelType.Request.RequestType)
}


final class SetupProfileInteractor: SetupProfileBuisnessLogic {
  
    var presenter: SetupProfilePresentationLogic?
    
    func makeRequest(request: SetupProfileModels.ModelType.Request.RequestType) {
        switch request {
            
        }
    }
}
