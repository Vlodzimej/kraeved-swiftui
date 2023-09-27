//
//  EventFeedView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 24.09.2023.
//

import SwiftUI

struct EventFeedView: View {
    let events: [HistoricalEvent]
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            //LazyVGrid(columns: gridItemLayout, spacing: 8) {
            HStack {
                ForEach(events, id: \.id) { event in
                    EventFeedCellView(event: event)
                }
                //}
            }
        }
    }
}
//
//#Preview {
//    EventFeedView()
//}

struct EventFeedView_Previews: PreviewProvider {
    static let events: [HistoricalEvent] = [
        .init(id: 0, name: "Name", desctiption: "Description", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg"),
        .init(id: 1, name: "Name2", desctiption: "Description2", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg"),
        .init(id: 2, name: "Name3", desctiption: "Description3", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg"),
        .init(id: 3, name: "Name4", desctiption: "Description4", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg"),
        .init(id: 4, name: "Name5", desctiption: "Description5", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg"),
        .init(id: 5, name: "Name6", desctiption: "Description6", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg"),
        .init(id: 6, name: "Name7", desctiption: "Description7", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg")
    ]
    
    static var previews: some View {
        EventFeedView(events: events)
    }
}
