//
//  ContentView.swift
//  playing-with-swiftui
//
//  Created by Kyle Lee on 9/21/20.
//

import Combine
import SwiftUI

struct ContentView: View {
    
    @State var token: AnyCancellable?
    
    @EnvironmentObject var box: Box

    
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear(perform: observeShortcuts)
    }
    
    private func observeShortcuts() {
        token = box.del!.sceneDelegate!.shortcutPublisher.sink { print($0) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
