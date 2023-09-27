//
//  MainView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

let attractions: [GeoObject] = [
    .init(id: 0, name: "Тестовый объект", description: "Описание для тестового объекта", longitude: 0, latitude: 0, type: .museum, imageUrl: nil),
    .init(id: 1, name: "Тестовый объект 2", description: "Описание для тестового объекта", longitude: 0, latitude: 0, type: .museum, imageUrl: nil),
    .init(id: 2, name: "Тестовый объект 3", description: "Описание для тестового объекта", longitude: 0, latitude: 0, type: .museum, imageUrl: nil),
    .init(id: 3, name: "Тестовый объект 4", description: "Описание для тестового объекта", longitude: 0, latitude: 0, type: .museum, imageUrl: nil),
    .init(id: 4, name: "Тестовый объект 5", description: "Описание для тестового объекта", longitude: 0, latitude: 0, type: .museum, imageUrl: nil)
]

let events: [HistoricalEvent] = [
    .init(id: 0, name: "Name", desctiption: "Description", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg"),
    .init(id: 1, name: "Name2", desctiption: "Description2", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg"),
    .init(id: 2, name: "Name3", desctiption: "Description3", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg"),
    .init(id: 3, name: "Name4", desctiption: "Description4", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg"),
    .init(id: 4, name: "Name5", desctiption: "Description5", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg"),
    .init(id: 5, name: "Name6", desctiption: "Description6", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg"),
    .init(id: 6, name: "Name7", desctiption: "Description7", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg")
]

struct MainView: View {
    @State private var searchText = ""
    //@ObservedObject var networkManager = NetworkManager.shared
    
    var body: some View {
        NavigationStack {
            ScrollView([.vertical], showsIndicators: false) {
                EventFeedView(events: events, openHistoricalEvent: { eventId in
                    print(eventId)
                })
                AttractionsView(geoObjects: attractions) { geoObjectId in
                    print(geoObjectId)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer)

            .background(Color.Kraeved.mainBackground)
            Spacer()
        }
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
