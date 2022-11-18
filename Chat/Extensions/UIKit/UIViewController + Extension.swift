//
//  UIViewController + Extension.swift
//  Chat
//
//  Created by Алиса Романова on 09.11.2022.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        self.present(alert, animated: true)
    }
    
    func showAlertGoToChat(handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: "Warning", message: "Do you want to start chatting with this user?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: handler))
        
        self.present(alert, animated: true)
    }
    
    
}

extension UIViewController {
    
    func liftUpView(amount: CGFloat) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) {
               [weak self] _ in

            self?.view.frame.origin.y = -amount
           }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) {
             [weak self] _ in

            self?.view.frame.origin.y = 0
         }
    }
}
