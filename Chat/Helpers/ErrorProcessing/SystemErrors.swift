//
//  SystemError.swift
//  Chat
//
//  Created by Алиса Романова on 17.11.2022.
//

import Foundation

enum SystemError {
    
    case failToAddUsersSnapshotListener
    case failToAddChatsSnapshotListener
    case failToAddMessagesSnapshotListener
    case metadataIsNil
    case failToFetchAvatarURL
    case failToDownloadAvatarURL
}

extension SystemError: LocalizedError {
    var errorDescription: String? {
        switch self {
            
        case .failToAddUsersSnapshotListener:
            return NSLocalizedString("Fail to add users SnapshotListener in ", comment: "")
        case .failToAddChatsSnapshotListener:
            return NSLocalizedString("Fail to add chats SnapshotListener in ", comment: "")
        case .failToAddMessagesSnapshotListener:
            return NSLocalizedString("Fail to add messages SnapshotListener in ", comment: "")
        case .failToFetchAvatarURL:
            return NSLocalizedString("Fail to fetch avatar URL", comment: "")
        case .metadataIsNil:
            return NSLocalizedString("Metadata is nil", comment: "")
        case .failToDownloadAvatarURL:
            return NSLocalizedString("Fail to download avatar url", comment: "")
        }
    }
}
