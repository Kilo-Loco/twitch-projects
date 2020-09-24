//
//  AppDelegate.swift
//  playing-with-swiftui
//
//  Created by Kyle Lee on 9/21/20.
//

import UIKit

final class CustomAppDelegate: NSObject, UIApplicationDelegate {
    
    
    private var shortcutItem: UIApplicationShortcutItem?
    
    var sceneDelegate: CustomSceneDelegate? {
        let scene = UIApplication.shared.connectedScenes.first
        return scene?.delegate as? CustomSceneDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("configure some service")

        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: "Custom Scene Delegate", sessionRole: connectingSceneSession.role)
        config.delegateClass = CustomSceneDelegate.self
        
        return config
    }
}
