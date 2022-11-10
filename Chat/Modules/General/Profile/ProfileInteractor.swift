//
//  ProfileInteractor.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

protocol ProfileBuisnessLogic {
    func makeRequest(request: ProfileModels.ModelType.Request.RequestType)
}


final class ProfileInteractor: ProfileBuisnessLogic {
  
    var presenter: ProfilePresentationLogic?
    
    func makeRequest(request: ProfileModels.ModelType.Request.RequestType) {
        switch request {
            
        }
    }
}
