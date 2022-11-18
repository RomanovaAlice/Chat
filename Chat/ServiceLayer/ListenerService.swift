//
//  ListenerService.swift
//  Chat
//
//  Created by Алиса Романова on 13.11.2022.
//

import FirebaseAuth
import FirebaseFirestore

final class ListenerService {
    
    //MARK: - Properties
    
    private var usersReference: CollectionReference {
        return Firestore.firestore().collection("Users")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    //MARK: - observeUsers
    
    func observeUsers(users: [Human], completion: @escaping (Result<[Human], Error>) -> Void) -> ListenerRegistration? {
        var users = users
        
        let usersListener = usersReference.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { (diff) in
                guard let user = Human(document: diff.document) else { return }
                
                switch diff.type {
                    
                case .added:
                    guard !users.contains(user) else { return }
                    guard user.id != self.currentUserId else { return }
                    users.append(user)
                    
                case .modified:
                    guard let index = users.firstIndex(of: user) else { return }
                    users[index] = user
                    
                case .removed:
                    guard let index = users.firstIndex(of: user) else { return }
                    users.remove(at: index)
                }
            }
            completion(.success(users))
        }
        return usersListener
    }
    
    //MARK: - observeChats
    
    func observeChats(chats: [Chat], completion: @escaping (Result<[Chat], Error>) -> Void) -> ListenerRegistration? {
        var chats = chats
        
        let chatsReference = Firestore.firestore().collection(["Users", currentUserId, "Chats"].joined(separator: "/"))
        
        let chatsListener = chatsReference.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { (diff) in
                guard let chat = Chat(document: diff.document) else { return }
                
                switch diff.type {
                    
                case .added:
                    guard !chats.contains(chat) else { return }
                    chats.append(chat)
                case .modified:
                    guard let index = chats.firstIndex(of: chat) else { return }
                    chats[index] = chat
                case .removed:
                    guard let index = chats.firstIndex(of: chat) else { return }
                    chats.remove(at: index)
                }
            }
            completion(.success(chats))
        }
        return chatsListener
    }
    
    //MARK: - observeMessages
    
    func observeMessages(chat: Chat, completion: @escaping (Result<Message, Error>) -> Void) -> ListenerRegistration? {
        
        let messagesReference = usersReference.document(currentUserId).collection("Chats").document(chat.userID).collection("Messages")
        
        let messagesListener = messagesReference.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { (diff) in
                guard let message = Message(document: diff.document) else { return }
                
                switch diff.type {
                    
                case .added:
                    completion(.success(message))
                case .modified:
                    break
                case .removed:
                    break
                }
            }
        }
        return messagesListener
    }
}
