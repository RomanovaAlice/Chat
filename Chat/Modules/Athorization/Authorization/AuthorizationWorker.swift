//
//  AuthorizationWorker.swift
//  Chat
//
//  Created by Алиса Романова on 29.10.2022.
//

import Firebase
import FirebaseAuth

protocol AuthorizationStorageLogic: AnyObject {
    
    func loginUser(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void)
    func registerUser(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void)
}


final class AuthorizationWorker: AuthorizationStorageLogic {
    
    
    func loginUser(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let email = email, let password = password else {
//            completion(.failure(AuthError.notFilled))
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    func registerUser(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: email!, password: password!) { (result, error) in
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
}
