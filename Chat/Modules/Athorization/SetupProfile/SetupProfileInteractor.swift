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
    var worker: SetUpProfileStorageLogic?
    
    private var id: String!
    private var email: String!
    
    func makeRequest(request: SetupProfileModels.ModelType.Request.RequestType) {
        switch request {
            
        case .getUserData(id: let id, email: let email):
            self.id = id
            self.email = email
            
        case .createUser(username: let username, description: let description, sex: let sex, avatar: let avatar):
            worker?.saveProfile(email: email,
                                username: username,
                                avatar: avatar,
                                description: description,
                                sex: sex,
                                id: id,
                                completion: { result in
                switch result{
                    
                case .success(_):
                    print("success")
                case .failure(let error):
                    print("error")
                }
            })
        }
    }
}
