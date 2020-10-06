//
//  ContentView.swift
//  infinite-scrolling-proto
//
//  Created by Kilo Loco on 10/5/20.
//

import SwiftUI

class SourceOfTruth: ObservableObject {
    @Published var users = [User]()
    
    func getUsers(at index: Int = 0) {
        
        print("fetching \(index)")
        
        switch index {
        case 0:
            users = [
                User(id: 1, name: "Kyle Lee"),
                User(id: 2, name: "Prathamesh Kowarkar"),
                User(id: 3, name: "Amit Samant"),
                User(id: 4, name: "EJ Hawkins"),
                User(id: 5, name: "Adriana Lee"),
                User(id: 6, name: "Andrew Valencia"),
                User(id: 7, name: "Xavier Lee"),
                User(id: 8, name: "Mya Lee")
            ]
            
        case 1:
            users.append(contentsOf: [
                User(id: 9, name: "Kilo Loco"),
                User(id: 10, name: "prtmshk"),
                User(id: 11, name: "amitamant"),
                User(id: 12, name: "esneaker30"),
                User(id: 13, name: "Adri"),
                User(id: 14, name: "Andy"),
                User(id: 15, name: "Xayxay"),
                User(id: 16, name: "My Love")
            ])
            
        case 2:
            users.append(
                contentsOf: Array(0 ..< 10).map { User(id: $0 + 20, name: UUID().uuidString) }
            )
            
        default:
            break
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var sot = SourceOfTruth()
    @State var nextIndex = 1
    
    
    init() {
        sot.getUsers()
        print("init")
    }
    
    var body: some View {
        NavigationView {
//            List(sot.users.indices, id: \.self) { index in
//                let user = sot.users[index]
//                Text(user.name)
//                    .padding(.vertical, 50)
//                    .onAppear {
//                        if index == sot.users.count - 2 {
//                            sot.getUsers(at: nextIndex)
//                            nextIndex += 1
//                        }
//                    }
//            }
            ScrollView {
                LazyVStack {
                    ForEach(sot.users.indices, id: \.self) { index in
                        let user = sot.users[index]
                        Text(user.name)
                            .padding(.vertical, 50)
                            .onAppear {
                                if index == sot.users.count - 2 {
                                    sot.getUsers(at: nextIndex)
                                    nextIndex += 1
                                }
                            }
                        Divider()
                    }
                }
            }
            .navigationTitle("Users")
        }
        .onAppear {
            print("appeared")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
