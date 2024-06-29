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
    @State private var isLoginPagePresented = true
    
    var body: some View {
        TabView {
            Group {
                MainView()
                    .tabItem {
                        Label("main.tabStartScreen", systemImage: "house")
                    }
                MapView()
                    .tabItem {
                        Label("main.tabMap", systemImage: "map")
                    }
                ProfilePageView()
                    .tabItem {
                        Label("main.tabProfile", systemImage: "gear")
                    }
            }
        }
        .onShake {
            LoggerStore.shared.storeMessage(
                label: "auth",
                level: .debug,
                message: "Will login user",
                metadata: ["userId": .string("uid-1")]
            )
            isLoggerPresented = true
        }
        .sheet(isPresented: $isLoggerPresented) {
            LoggerView()
        }
        .onAppear() {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = nil
            appearance.backgroundColor = .Kraeved.mainBackground
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
//
//            let navAppearance = UINavigationBarAppearance()
//            navAppearance.backgroundColor = .red
//            UINavigationBar.appearance().standardAppearance = navAppearance
//            UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        }
//
//            UITabBar.appearance().backgroundColor = UIColor.Kraeved.mainBackground
//            UITabBar.appearance().alpha = 1
//            UITabBar.appearance().overrideUserInterfaceStyle = .light
            //            UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setImage(UIImage.magnifyingGlass, for: .search, state: .normal)
            //
            //            UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setImage(nil, for: .clear, state: .normal)
            //
            //            UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = UIColor.Kraeved.titleFontMain
            //
            //            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.Kraeved.mainBackground
            //
            //            UISearchTextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: [.foregroundColor: UIColor.Kraeved.searchFont])
//        }
        .tint(.Kraeved.titleFontMain)
    }
}

#Preview {
    ContentView()
}
