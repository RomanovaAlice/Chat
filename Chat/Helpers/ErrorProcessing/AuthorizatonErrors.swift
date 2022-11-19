//
//  AuthorizatonError.swift
//  Chat
//
//  Created by Алиса Романова on 17.11.2022.
//

import Foundation

enum AuthorizationError {
    
    case passwordsNotMatch
    case fieldsNotFilled
    case userNotExist
    case serverError
    case invalidEmail
    case invalidPassword
    case imageNotLoaded
    case failToSaveProfile
}

extension AuthorizationError: LocalizedError {
    var errorDescription: String? {
        switch self {

        case .passwordsNotMatch:
            return NSLocalizedString("Passwords do not match", comment: "")
        case .fieldsNotFilled:
            return NSLocalizedString("All fields must be filled", comment: "")
        case .userNotExist:
            return NSLocalizedString("User does not exist, please try again", comment: "")
        case .serverError:
            return NSLocalizedString("Sorry, an error occurred, please try again", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Mail format does not meet the standard", comment: "")
        case .invalidPassword:
            return NSLocalizedString("Your password is too simple", comment: "")
        case .imageNotLoaded:
            return NSLocalizedString("Upload profile photo", comment: "")
        case .failToSaveProfile:
            return NSLocalizedString("Fail to save profile", comment: "")
        }
    }
}
