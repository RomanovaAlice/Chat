//
//  UIViewController + Extension.swift
//  Chat
//
//  Created by Алиса Романова on 09.11.2022.
//

import UIKit

extension UIViewController {
    
    func showAlertFillAllTextFields() {
        let alert = UIAlertController(title: "Warning", message: "All fields must be filled", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        self.present(alert, animated: true)
    }
    
    func showAlertUserDoesNotExist() {
        let alert = UIAlertController(title: "Warning", message: "User does not exist, please try again", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        self.present(alert, animated: true)
    }
    
    func showAlertPasswordsDoNotMatch() {
        let alert = UIAlertController(title: "Warning", message: "Passwords do not match", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        self.present(alert, animated: true)
    }
    
    func showAlertServerError() {
        let alert = UIAlertController(title: "Warning", message: "Sorry, an error occurred, please try again", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        self.present(alert, animated: true)
    }
}
