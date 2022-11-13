//
//  Human.swift
//  Chat
//
//  Created by Алиса Романова on 13.11.2022.
//

import Foundation

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
}
