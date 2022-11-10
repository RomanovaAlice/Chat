//
//  SignUpWorker.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Firebase
import FirebaseAuth

protocol SignUpStorageLogic {
    func registerUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}


final class SignUpWorker: SignUpStorageLogic {
    
    func registerUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
}
