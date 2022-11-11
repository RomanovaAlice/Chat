//
//  LoginWorker.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import FirebaseAuth

protocol LoginStorageLogic {
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}


final class LoginWorker: LoginStorageLogic {
    
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {

        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
}

