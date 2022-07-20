//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Денис Штоколов on 28.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let habitsViewController = HabitsViewController()
        let infoViewController = InfoViewController()
        let navigationVC1 = UINavigationController(rootViewController: habitsViewController)
        let navigationVC2 = UINavigationController(rootViewController: infoViewController)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            navigationVC1, navigationVC2
        ]
        let image1 = UIImage(systemName: "list.bullet")
        let image2 = UIImage(systemName: "info.circle.fill")
        navigationVC1.tabBarItem.image = image1
        navigationVC2.tabBarItem.image = image2
        navigationVC1.tabBarItem.title = "Привычки"
        navigationVC2.tabBarItem.title = "Информация"
        navigationVC1.tabBarController?.tabBar.tintColor = UIColor(named: "violet")
        navigationVC2.tabBarController?.tabBar.tintColor = UIColor(named: "violet")
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}

