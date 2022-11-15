//
//  AuthorizationService.swift
//  Chat
//
//  Created by Алиса Романова on 13.11.2022.
//

import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

final class AuthorizationService {
    
    //MARK: - Properties
    
    private var usersReference: CollectionReference {
        return Firestore.firestore().collection("Users")
    }
    
    private var avatarsReference: StorageReference {
        return Storage.storage().reference().child("Avatars")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
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
    
    //MARK: - getUserData
    
    func getUserData(user: User, completion: @escaping (Result<Human, Error>) -> Void) {
        usersReference.document(user.uid).getDocument { (document, _) in
            if let document = document, document.exists {
                
                let userData = document.data() as! [String: String]
                
                let user = Human(username: userData["username"]!,
                                 email: userData["email"]!,
                                 avatar: userData["avatar"]!,
                                 description: userData["description"]!,
                                 sex: userData["sex"]!,
                                 id: userData["id"]!)
    
                completion(.success(user))

            } else {
                completion(.failure(AuthorizationError.serverError))
            }
        }
    }
    
    //MARK: - saveProfile
    
    func saveProfile(userData: Human, avatar: UIImage?, completion: @escaping (Result<Human, Error>) -> Void) {
        
        guard Validators.isAllFieldsFilled(username: userData.username, description: userData.description) else {
            completion(.failure(AuthorizationError.fieldsNotFilled))
            return
        }
        
        guard Validators.isAvatarExist(avatar: avatar) else {
            completion(.failure(AuthorizationError.imageNotLoaded))
            return
        }
        
        var user = Human(username: userData.username,
                         email: userData.email,
                         avatar: "not exist",
                         description: userData.description,
                         sex: userData.sex,
                         id: userData.id)
        
        loadUserPhoto(photo: avatar!) { result in
            switch result {
                
            case .success(let url):
                user.avatar = url.absoluteString

                self.usersReference.document(user.id).setData(user.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(user))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - loadUserPhoto

    private func loadUserPhoto(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = photo.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        avatarsReference.child(currentUserId).putData(imageData, metadata: metadata) { (metadata, error) in
            
            if metadata == nil {
                completion(.failure(error!))
            }
            
            self.avatarsReference.child(self.currentUserId).downloadURL { (url, error) in
                guard let downloadURL = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(downloadURL))
            }
        }
    }
}
