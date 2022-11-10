//
//  ChatPresenter.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

protocol ChatPresentationLogic {
    func presentData(response: ChatModels.ModelType.Response.ResponseType)
}


final class ChatPresenter: ChatPresentationLogic {

    weak var view: ChatDisplayLogic?
    
    func presentData(response: ChatModels.ModelType.Response.ResponseType) {
        switch response {
            
        }
    }
}
