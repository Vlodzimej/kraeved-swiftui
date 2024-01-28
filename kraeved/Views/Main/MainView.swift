//
//  MainView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

//MARK: - MainView
struct MainView: View {
    @State private var geoObjects: [GeoObjectBrief] = []
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                EventFeedView()
                AttractionsFeedView()
            }
            .background(Color.Kraeved.mainBackground)
        }
        //.searchable(text: $searchText, placement: .navigationBarDrawer)
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.Kraeved.mainBackground)
            appearance.shadowColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
}

#Preview {
    MainView()
}
