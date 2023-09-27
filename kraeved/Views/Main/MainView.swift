//
//  MainView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

struct MainView: View {
    @State private var searchText = ""
    //@ObservedObject var networkManager = NetworkManager.shared
    
    var body: some View {
        NavigationStack {
            ScrollView([.vertical], showsIndicators: false) {
                EventFeedView(events: EventFeedView_Previews.events, openHistoricalEvent: { eventId in
                    print(eventId)
                })
            }
            .background(Color.mainBackground)
            Spacer()
        }
        .searchable(text: $searchText)
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.mainBackground)
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
}

#Preview {
    MainView()
}
