//
//  ChatInteractor.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

protocol ChatBuisnessLogic {
    func makeRequest(request: ChatModels.ModelType.Request.RequestType)
}


final class ChatInteractor: ChatBuisnessLogic {
  
    var presenter: ChatPresentationLogic?
    
    func makeRequest(request: ChatModels.ModelType.Request.RequestType) {
        switch request {
            
        }
    }
}
