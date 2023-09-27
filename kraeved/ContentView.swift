//
//  ContentView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

struct ContentView: View {
//    @State private var searchText = ""
//    @State private var searchIsActive = false
    
    var body: some View {
        TabView {
            Group {
                MainView()
                    .tabItem {
                        Label("Main", systemImage: "house")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                MapView()
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
                ServicesView()
                    .tabItem {
                        Label("Services", systemImage: "app")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "gear")
                    }
            }
            .toolbarBackground(Color.Kraeved.mainBackground, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.none, for: .tabBar)
        }
        .onAppear() {
            UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setImage(UIImage.magnifyingGlass, for: .search, state: .normal)

            UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setImage(nil, for: .clear, state: .normal)

            UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = UIColor.Kraeved.titleFontMain

            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.Kraeved.mainBackground

            UISearchTextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search", attributes: [.foregroundColor: UIColor.Kraeved.searchFont])
        }
    }
}

#Preview {
    ContentView()
}
