//
//  ContentView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI
import Pulse

struct ContentView: View {
    @State private var isLoggerPresented = false
    
    var body: some View {
        
        TabView {
            Group {
                MainView()
                    .tabItem {
                        Label("Main", systemImage: "house")
                    }
                MapView()
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "gear")
                    }
            }
        }.onShake {
            LoggerStore.shared.storeMessage(
                label: "auth",
                level: .debug,
                message: "Will login user",
                metadata: ["userId": .string("uid-1")]
            )
            isLoggerPresented = true
        }.sheet(isPresented: $isLoggerPresented) {
            LoggerView()
        }

        .onAppear() {
            //            UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setImage(UIImage.magnifyingGlass, for: .search, state: .normal)
            //
            //            UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setImage(nil, for: .clear, state: .normal)
            //
            //            UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = UIColor.Kraeved.titleFontMain
            //
            //            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.Kraeved.mainBackground
            //
            //            UISearchTextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: [.foregroundColor: UIColor.Kraeved.searchFont])
        }
    }
}

#Preview {
    ContentView()
}
