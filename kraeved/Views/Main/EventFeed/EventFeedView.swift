//
//  EventFeedView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 24.09.2023.
//

import SwiftUI

struct EventFeedView: View {
    let events: [HistoricalEvent]
    let openHistoricalEvent: ((_ id: Int) -> Void)?
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        VStack(alignment: .leading) {
            MainTitle(title: "События", image: "titleUnderline")
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(events, id: \.id) { event in
                        let isFirstElement = events.first == event
                        let isLastElement = events.last == event
                        
                        EventFeedCellView(event: event, tappedAction: { selectedEvent in
                            self.openHistoricalEvent?(selectedEvent.id)
                        })
                        .padding(EdgeInsets(top: 0, leading: isFirstElement ? 16 : 0, bottom: 0, trailing: isLastElement ? 16 : 0))
                    }
                }
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
        EventFeedView(events: events, openHistoricalEvent: nil)
    }
}
