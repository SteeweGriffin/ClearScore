//
//  SceneDelegate.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 20/07/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = makeRoot()
        window?.makeKeyAndVisible()
    }
    
    private func makeRoot() -> UIViewController {
        let controller = ViewController()
        let navigation = UINavigationController(rootViewController: controller)
        return navigation
    }

}

