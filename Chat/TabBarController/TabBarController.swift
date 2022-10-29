//
//  TabBarController.swift
//  Chat
//
//  Created by Алиса Романова on 29.10.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chatViewController = ChatViewController()
        
        tabBar.tintColor = UIColor(named: "purple")

        let messageImage = UIImage(systemName: "bubble.left.and.bubble.right")
        
        viewControllers = [
            generateNavigationController(rootViewController: chatViewController, title: "Messages", image: messageImage!),
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
