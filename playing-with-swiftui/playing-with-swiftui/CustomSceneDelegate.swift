//
//  CustomSceneDelegate.swift
//  playing-with-swiftui
//
//  Created by Kyle Lee on 9/21/20.
//

import Combine
import UIKit

final class CustomSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let shortcutPublisher = PassthroughSubject<Shortcut, Never>()
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        let shortcut: Shortcut = shortcutItem.userInfo?["Name"] as? String == "Custom Search"
            ? .search
            : .post
        shortcutPublisher.send(shortcut)
        completionHandler(true)
    }
}

enum Shortcut {
    case search, post
}
