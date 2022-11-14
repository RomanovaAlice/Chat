//
//  ListenerService.swift
//  Chat
//
//  Created by Алиса Романова on 13.11.2022.
//

import FirebaseAuth
import FirebaseFirestore

final class ListenerService {
    
    private var usersReference: CollectionReference {
        return Firestore.firestore().collection("Users")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
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
}
