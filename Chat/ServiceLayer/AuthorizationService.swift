//
//  AuthorizationService.swift
//  Chat
//
//  Created by Алиса Романова on 13.11.2022.
//

import FirebaseAuth
import FirebaseFirestore

final class AuthorizationService {
    
    //MARK: - Properties
    
    private var usersReference: CollectionReference {
        return Firestore.firestore().collection("Users")
    }
    
    //MARK: - loginUser
    
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard Validators.isAllFieldsFilled(email: email, password: password) else {
            completion(.failure(AuthorizationError.fieldsNotFilled))
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, _) in
            
            guard let result = result else {
                completion(.failure(AuthorizationError.userNotExist))
                return
            }
            completion(.success(result.user))
        }
    }
    
    //MARK: - registerUser
    
    func registerUser(email: String, password: String, confirmPassword: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard Validators.isAllFieldsFilled(email: email, password: password, confirmPassword: confirmPassword) else {
            completion(.failure(AuthorizationError.fieldsNotFilled))
            return
        }
        
        guard Validators.isEmailValid(email: email) else {
            completion(.failure(AuthorizationError.invalidEmail))
            return
        }
        
        guard Validators.isPasswordValid(password: password) else {
            completion(.failure(AuthorizationError.invalidPassword))
            return
        }
        
        guard Validators.isPasswordsMatch(password: password, confirmPassword: confirmPassword) else {
            completion(.failure(AuthorizationError.passwordsNotMatch))
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, _) in
            
            guard let result = result else {
                completion(.failure(AuthorizationError.serverError))
                return
            }
            completion(.success(result.user))
        }
    }
}
