//
//  AppDelegate.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import Amplify
import AmplifyPlugins
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureAmplify()
        return true
    }
    
    private func configureAmplify() {
        do {
            let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.configure()
            
            print("yay")
            
        } catch {
            print(error)
        }
    }

}

