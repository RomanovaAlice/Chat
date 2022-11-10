//
//  ProfilePresenter.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

protocol ProfilePresentationLogic {
    func presentData(response: ProfileModels.ModelType.Response.ResponseType)
}


final class ProfilePresenter: ProfilePresentationLogic {

    weak var view: ProfileDisplayLogic?
    
    func presentData(response: ProfileModels.ModelType.Response.ResponseType) {
        switch response {
            
        }
    }
}
