//
//  TabBarController.swift
//  Chat
//
//  Created by Алиса Романова on 29.10.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private let currentUser: Human
    
    init(currentUser: Human) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chatViewController = ChatViewController(currentUser: currentUser)
        let usersViewController = UsersViewController()
        let profileViewController = ProfileViewController(userData: currentUser)
        
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
        
        let navigationViewCcontroller = UINavigationController(rootViewController: rootViewController)
        navigationViewCcontroller.tabBarItem.title = title
        navigationViewCcontroller.tabBarItem.image = image
        return navigationViewCcontroller
    }
}
