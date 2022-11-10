//
//  UsersInteractor.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

protocol UsersBuisnessLogic {
    func makeRequest(request: UsersModels.ModelType.Request.RequestType)
}


final class UsersInteractor: UsersBuisnessLogic {
  
    var presenter: UsersPresentationLogic?
    
    func makeRequest(request: UsersModels.ModelType.Request.RequestType) {
        switch request {
            
        }
    }
}
