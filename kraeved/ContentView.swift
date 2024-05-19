//
//  ContentView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI
import Pulse

struct ContentView: View {
    var body: some View {
        TabView {
            Group {
                MainView()
                    .tabItem {
                        Label("main-tab-start-screen", systemImage: "house")
                    }
                MapView()
                    .tabItem {
                        Label("main-tab-map", systemImage: "map")
                    }
                ProfileView()
                    .tabItem {
                        Label("main-tab-profile", systemImage: "gear")
                    }
            }
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
        .tint(.Kraeved.titleFontMain)
    }
}

#Preview {
    ContentView()
}
