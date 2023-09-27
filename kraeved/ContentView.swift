//
//  ContentView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var searchIsActive = false
    
    var body: some View {
        TabView {
            NavigationView {
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
        }
    }
}

#Preview {
    ContentView()
}
