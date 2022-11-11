//
//  SetupProfileWorker.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import FirebaseFirestore
import FirebaseCore

protocol SetUpProfileStorageLogic {
    func saveProfile(email: String, username: String, avatar: String, description: String, sex: String, id: String, completion: @escaping (Result<Human, Error>) -> Void)
}


final class SetupProfileWorker: SetUpProfileStorageLogic {
    
    private var usersReference: CollectionReference {
        return Firestore.firestore().collection("Users")
    }
    
    func saveProfile(email: String, username: String, avatar: String, description: String, sex: String, id: String, completion: @escaping (Result<Human, Error>) -> Void) {
        

        
        
        let user = Human(email: email, username: username, description: description, sex: sex, avatar: avatar, id: id)
        
        usersReference.document(user.id).setData(user.representation) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
}
