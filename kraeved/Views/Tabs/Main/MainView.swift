//
//  MainView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

//MARK: - MainView
struct MainView: View {
    //@State private var geoObjects: [GeoObjectBrief] = []
    //@State private var searchText = ""
    
    let eventFeedView = HistoricalEventFeedView()
    let attractionsFeedView = AttractionsFeedView()
    
    var body: some View {
        NavigationView {
            ScrollView {
                eventFeedView
                attractionsFeedView
            }
            .background(Color.Kraeved.mainBackground)
            .refreshable {
                await reload()
            }
        }
        //.searchable(text: $searchText, placement: .navigationBarDrawer)
    }
    
    private func reload() async {
        await eventFeedView.reload()
        await attractionsFeedView.reload()
    }
}

#Preview {
    MainView()
}
