//
//  HistoricalEventFeedView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 24.09.2023.
//

import SwiftUI

struct HistoricalEventFeedView: View {
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            MainTitle(title: "historical-events-title", image: "titleUnderline")
                .padding(EdgeInsets(top: 0, leading: 16, bottom: -8, trailing: 0))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.historicalEvents ?? .init(repeating: .init(), count: 6), id: \.id) { event in
                        NavigationLink(destination: HistoricalEventDetailsView(id: event.id)) {
                            HistoricalEventFeedCellView(event: event)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        }
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            }
        }
        .task {
            await reload()
        }
    }
    
    func reload() async {
        Task {
            await viewModel.getHistoricalEvents()
        }
    }
}

//
//#Preview {
//    let events: [HistoricalEvent] = []
//    
//    return EventFeedView(events: events, openHistoricalEvent: { eventId in
//        print(eventId)
//    })
//}
