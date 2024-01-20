//
//  ContentView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var networkManager = NetworkManager.shared
    
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
        }
        .environmentObject(networkManager)
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
