//
//  Validators.swift
//  Chat
//
//  Created by Алиса Романова on 10.11.2022.
//

import Foundation

final class Validators {
    
    static func isAllFieldsFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
        
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
    
    static func isAllFieldsFilledAndPasswordsMatch(email: String?, password: String?, confirmPassword: String?) -> Bool {
        
        if (email?.count != 0 && password?.count != 0 && confirmPassword?.count != 0) && (password == confirmPassword) {
            return true
        } else {
            return false
        }
    }

}
