//
//  FirestoreService.swift
//  Chat
//
//  Created by Алиса Романова on 17.11.2022.
//

import FirebaseFirestore
import FirebaseAuth

final class FirestoreService {
    
    static let shared = FirestoreService()
    
    //MARK: - Properties
    
    private let storageService = StorageService()
    
    var currentUser: Human?
    
    private let db = Firestore.firestore()
    
    //MARK: - getUserData
    
    func getUserData(user: User, completion: @escaping (Result<Human, Error>) -> Void) {
        db.collection("Users").document(user.uid).getDocument { (document, _) in
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
        
        storageService.loadUserPhoto(photo: avatar!) { result in
            switch result {
                
            case .success(let url):
                user.avatar = url.absoluteString

                self.db.collection("Users").document(user.id).setData(user.representation) { (error) in
                    if error != nil {
                        completion(.failure(error!))
                    } else {
                        completion(.success(user))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - createChat
    
    func createChat(friend: Human, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let currentUser = currentUser else { return }
        
        let friendReference = db.collection("Users").document(friend.id).collection("Chats").document(currentUser.id)
        let currentUserReferens = db.collection("Users").document(currentUser.id).collection("Chats").document(friend.id)
        
        let friendChat = Chat(username: currentUser.username,
                        userAvatar: currentUser.avatar,
                        userID: currentUser.id)
        
        let currentUserChat = Chat(username: friend.username,
                                   userAvatar: friend.avatar,
                                   userID: friend.id)
        
        currentUserReferens.setData(currentUserChat.representation) { error in
            if error != nil {
                completion(.failure(AuthorizationError.serverError))
                return
            }
            completion(.success(Void()))
        }
        friendReference.setData(friendChat.representation) { error in
            if error != nil {
                completion(.failure(AuthorizationError.serverError))
                return
            }
            completion(.success(Void()))
        }
    }
    
    //MARK: - sendMessage
    
    func sendMessage(chat: Chat, message: Message, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let currentUser = currentUser else { return }
        
        let friendReference = db.collection("Users").document(chat.userID).collection("Chats").document(currentUser.id).collection("Messages")
        let currentUserReferens = db.collection("Users").document(currentUser.id).collection("Chats").document(chat.userID).collection("Messages")
        
        friendReference.addDocument(data: message.representation) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            currentUserReferens.addDocument(data: message.representation) { (error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(Void()))
            }
        }
    }
}
