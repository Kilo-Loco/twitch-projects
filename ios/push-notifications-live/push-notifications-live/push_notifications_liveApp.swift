//
//  push_notifications_liveApp.swift
//  push-notifications-live
//
//  Created by Kilo Loco on 1/5/21.
//

import Amplify
import AmplifyPlugins
import SwiftUI

class DeviceTokenManager {
    private init() {}
    static let shared = DeviceTokenManager()
    
    var deviceToken: String?
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("device token", deviceToken)
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        DeviceTokenManager.shared.deviceToken = token
    }
}

@main
struct push_notifications_liveApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State var notificationService = NotificationService()
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationService)
        }
    }
    
    func configureAmplify() {
        do {
            let models = AmplifyModels()
            
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: models))
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: models))
            try Amplify.configure()
            
            print("Configured")
            
        } catch {
            print(error)
        }
    }
}
