//
//  SceneDelegate.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: Properties
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let newsController = NewsViewController()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = newsController
        window?.makeKeyAndVisible()
    }
}
