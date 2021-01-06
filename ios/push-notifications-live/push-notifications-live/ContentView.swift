//
//  ContentView.swift
//  push-notifications-live
//
//  Created by Kilo Loco on 1/5/21.
//

import Amplify
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var notificationService: NotificationService
    
    @State var text = ""
    
    var body: some View {
        VStack {
            TextField("Enter a message", text: $text)
            
            Button("Send Message", action: sendMessage)
        }
        .padding()
        .onAppear(perform: notificationService.requestPermission)
    }
    
    func sendMessage() {
        guard let deviceToken = DeviceTokenManager.shared.deviceToken else { return }
        
        let message = Message(body: text, deviceToken: deviceToken)
        Amplify.DataStore.save(message) { result in
            do {
                let savedMessage = try result.get()
                print("Saved", savedMessage)
                text.removeAll()
                
            } catch {
                print(error)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
