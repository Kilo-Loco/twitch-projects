//
//  playing_with_swiftuiApp.swift
//  playing-with-swiftui
//
//  Created by Kyle Lee on 9/21/20.
//

import SwiftUI

class Box: ObservableObject {
    var del: CustomAppDelegate?
}
@main
struct playing_with_swiftuiApp: App {
    
    @UIApplicationDelegateAdaptor(CustomAppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var phase
    @ObservedObject var box = Box()
    
    var body: some Scene {
        box.del = appDelegate
        
        return WindowGroup {
            ContentView()
                .environmentObject(box)
        }
        .onChange(of: phase) { action in
            print(action)
        }
    }
    
    
}
