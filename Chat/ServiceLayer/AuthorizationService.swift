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
    
    private var usersReference: CollectionReference {
        return Firestore.firestore().collection("Users")
    }
    
    private var avatarsReference: StorageReference {
        return Storage.storage().reference().child("Avatars")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {

        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    func saveProfile(userData: Human, avatar: UIImage, completion: @escaping (Result<Human, Error>) -> Void) {
        
        var user = Human(email: userData.email,
                         username: userData.username,
                         description: userData.description,
                         sex: userData.sex,
                         avatar: "not exist",
                         id: userData.id)
        
        loadUserPhoto(photo: avatar) { result in
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

    private func loadUserPhoto(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        if photo != UIImage(named: "userMessage") {
            
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
}
