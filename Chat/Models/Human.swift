//
//  Human.swift
//  Chat
//
//  Created by Алиса Романова on 13.11.2022.
//

import FirebaseFirestore

struct Human: Hashable, Decodable {
    
    let email: String
    let username: String
    let description: String
    let sex: String
    var avatar: String
    let id: String
    
    var representation: [String: Any] {
        var dictionary: [String: Any] = [:]
        
        dictionary["username"] = username
        dictionary["sex"] = sex
        dictionary["email"] = email
        dictionary["avatar"] = avatar
        dictionary["description"] = description
        dictionary["sex"] = sex
        dictionary["id"] = id
        
        return dictionary
    }
    
    init(username: String, email: String, avatar: String, description: String, sex: String, id: String) {
        self.username = username
        self.email = email
        self.avatar = avatar
        self.description = description
        self.sex = sex
        self.id = id
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let username = data["username"] as? String,
        let email = data["email"] as? String,
        let avatar = data["avatar"] as? String,
        let description = data["description"] as? String,
        let sex = data["sex"] as? String,
        let id = data["id"] as? String else { return nil }
        
        self.username = username
        self.email = email
        self.avatar = avatar
        self.description = description
        self.sex = sex
        self.id = id
    }
}
