//
//  UserError.swift
//  Chat
//
//  Created by Алиса Романова on 17.11.2022.
//

import Foundation

enum UserError {
    case repeatingUser
    
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
            
        case .repeatingUser:
            return NSLocalizedString("You cannot chat with this user again", comment: "")
        }
    }
}
