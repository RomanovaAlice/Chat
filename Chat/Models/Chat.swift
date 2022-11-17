//
//  Chat.swift
//  Chat
//
//  Created by Алиса Романова on 11.11.2022.
//

import FirebaseFirestore

struct Chat: Hashable, Decodable {
    
    var username: String
    var userAvatar: String
    var userID: String
    
    var representation: [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["username"] = username
        dictionary["userAvatar"] = userAvatar
        dictionary["userID"] = userID
        
        return dictionary
    }
    
    init(username: String, userAvatar: String, userID: String) {
        self.username = username
        self.userAvatar = userAvatar
        self.userID = userID
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let username = data["username"] as? String,
        let userAvatar = data["userAvatar"] as? String,
        let userID = data["userID"] as? String else { return nil }
        
        self.username = username
        self.userAvatar = userAvatar
        self.userID = userID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(userID)
    }
    
    static func == (lhs: Chat, rhs: Chat) -> Bool {
        return lhs.userID == rhs.userID
    }
}
