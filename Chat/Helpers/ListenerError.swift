//
//  ListenerError.swift
//  Chat
//
//  Created by Алиса Романова on 18.11.2022.
//

import Foundation

enum ListenerError {
    
    case failToAddSnapshotListener
}

extension ListenerError: LocalizedError {
    var errorDescription: String? {
        switch self {
            
        case .failToAddSnapshotListener:
            return NSLocalizedString("Passwords do not match", comment: "")
        }
    }
}
