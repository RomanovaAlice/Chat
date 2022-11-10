//
//  UsersPresenter.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

protocol UsersPresentationLogic {
    func presentData(response: UsersModels.ModelType.Response.ResponseType)
}


final class UsersPresenter: UsersPresentationLogic {

    weak var view: UsersDisplayLogic?
    
    func presentData(response: UsersModels.ModelType.Response.ResponseType) {
        switch response {
            
        }
    }
}
