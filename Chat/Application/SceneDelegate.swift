//
//  SceneDelegate.swift
//  Chat
//
//  Created by Alice Romanova on 23.10.2022.
//

import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        if let user = Auth.auth().currentUser {
            FirestoreService.shared.getUserData(user: user) { (result) in
                switch result {

                case .success(let user):
                    FirestoreService.shared.currentUser = user
                    
                    let tabBar = TabBarController(currentUser: user)
                    tabBar.modalPresentationStyle = .fullScreen
                    self.window?.rootViewController = tabBar

                case .failure(_):
                    self.window?.rootViewController = AuthorizationViewController()
                }
            }
        } else {
            window?.rootViewController = AuthorizationViewController()
        }

        
        window?.makeKeyAndVisible()
    }
}
