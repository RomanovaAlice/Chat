//
//  SetupProfileWorker.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

protocol SetUpProfileStorageLogic {
    func saveProfile(email: String, username: String, avatar: UIImage, description: String, sex: String, id: String, completion: @escaping (Result<Human, Error>) -> Void)
}


final class SetupProfileWorker: SetUpProfileStorageLogic {
    
    private var usersReference: CollectionReference {
        return Firestore.firestore().collection("Users")
    }
    
    private var avatarsReference: StorageReference {
        return Storage.storage().reference().child("Avatars")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    
    func saveProfile(email: String, username: String, avatar: UIImage, description: String, sex: String, id: String, completion: @escaping (Result<Human, Error>) -> Void) {
        
        var user = Human(email: email, username: username, description: description, sex: sex, avatar: "not exist", id: id)
        
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
                guard let _ = metadata else {
                    completion(.failure(error!))
                    return
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
