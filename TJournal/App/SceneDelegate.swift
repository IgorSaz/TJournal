//
//  SceneDelegate.swift
//  TJournal
//
//  Created by Игорь Сазонов on 22.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let newsFeedViewController = BuilderModule.shared.createNewsFeedModule()
        window?.rootViewController = UINavigationController(rootViewController: newsFeedViewController)
        window?.makeKeyAndVisible()
    }
}

