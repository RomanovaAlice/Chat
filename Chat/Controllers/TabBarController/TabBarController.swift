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
        let usersViewController = UsersViewController()
        let profileViewController = ProfileViewController()
        
        tabBar.tintColor = UIColor(named: "purple")

        let messageImage = UIImage(systemName: "bubble.left.and.bubble.right")
        let usersImage = UIImage(systemName: "person.3")
        let profileImage = UIImage(systemName: "person")
        
        viewControllers = [
            generateNavigationController(rootViewController: usersViewController, title: "People", image: usersImage!),
            generateNavigationController(rootViewController: chatViewController, title: "Messages", image: messageImage!),
            generateNavigationController(rootViewController: profileViewController, title: "Profile", image: profileImage!)
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
