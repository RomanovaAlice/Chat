//
//  Chat.swift
//  Chat
//
//  Created by Алиса Романова on 11.11.2022.
//

import Foundation

struct Chat: Hashable, Decodable {
    
    var username: String
    var userImage: String
    var lastMessage: String
}
