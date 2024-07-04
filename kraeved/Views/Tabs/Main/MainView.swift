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
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                eventFeedView
                attractionsFeedView
            }
            .refreshable {
                await reload()
            }
            .toolbar(.visible)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    TextField("common.search", text: $searchText)
                }
            }
        }

        //.searchable(text: $searchText, placement: .navigationBarDrawer)
    }
    
    let eventFeedView = HistoricalEventFeedView()
    
    let attractionsFeedView = AttractionsFeedView()
    
    private func reload() async {
        await eventFeedView.reload()
        await attractionsFeedView.reload()
    }
}

#Preview {
    MainView()
}
