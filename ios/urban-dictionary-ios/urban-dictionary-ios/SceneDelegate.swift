//
//  SceneDelegate.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: sceneWindow)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }

    
    
    
    var tabBarController: UITabBarController {
        
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        
        let searchNavController = UINavigationController()
        searchNavController.navigationBar.prefersLargeTitles = true
        searchNavController.viewControllers = [searchVC]
        searchNavController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        
        let historyVC = HistoryViewController()
        historyVC.title = "History"
        
        let historyNavController = UINavigationController()
        historyNavController.navigationBar.prefersLargeTitles = true
        historyNavController.viewControllers = [historyVC]
        historyNavController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "list.bullet"), tag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            searchNavController,
            historyNavController
        ]
        
        return tabBarController
    }
    
    
}

