//
//  Validators.swift
//  Chat
//
//  Created by Алиса Романова on 10.11.2022.
//

import Foundation

final class Validators {
    
    static func isAvatarExist(avatar: AnyObject?) -> Bool {
        if avatar != nil {
            return true
        } else {
             return false
        }
    }
    
    static func isPasswordValid(password: String) -> Bool {
        if password.count < 6 {
            return false
        } else {
            return true
        }
    }
    
    static func isEmailValid(email: String) -> Bool {
        if isSimpleEmail(email: email) {
            return false
        } else {
            return true
        }
    }
    
    static func isAllFieldsFilled(email: String?, password: String?, confirmPassword: String? = nil) -> Bool {
        
        if confirmPassword != nil {
            
            if email?.count != 0 && password?.count != 0 && confirmPassword?.count != 0 {
                return true
            } else {
                return false
            }
            
        } else {
            if email?.count != 0 && password?.count != 0 {
                return true
            } else {
                return false
            }
        }
    }
    
    static func isAllFieldsFilled(username: String?, description: String?) -> Bool {
        
        if username?.count != 0 && description?.count != 0 {
            return true
        } else {
            return false
        }
    }
    
    static func isPasswordsMatch(password: String?, confirmPassword: String?) -> Bool {
        
        if password == confirmPassword {
            return true
        } else {
            return false
        }
    }
    
    private static func isSimpleEmail(email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return !(check(text: email, regEx: emailRegEx))
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
