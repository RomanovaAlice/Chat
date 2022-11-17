//
//  Message.swift
//  Chat
//
//  Created by Алиса Романова on 17.11.2022.
//

import FirebaseFirestore
import MessageKit

struct Message: Hashable, MessageType {
   
    let content: String
    var sender: SenderType
    var sentDate: Date
    let id: String?
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var kind: MessageKind {
        return .text(content)
    }
    
    init(user: Human, content: String) {
        self.content = content
        sender = Sender(senderId: user.id, displayName: user.username)
        sentDate = Date()
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let senderId = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        guard let content = data["content"] as? String else { return nil }
        
        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        sender = Sender(senderId: senderId, displayName: senderName)
        self.content = content
    }
    
    var representation: [String: Any] {
        
        var dictionary: [String: Any] = [:]
        dictionary["created"] = sentDate
        dictionary["senderID"] = sender.senderId
        dictionary["senderUserame"] = sender.displayName
        dictionary["content"] = content
        
        return dictionary
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.messageId == rhs.messageId
    }
}
