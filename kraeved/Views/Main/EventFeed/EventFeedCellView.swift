//
//  EventFeedCellView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 24.09.2023.
//

import SwiftUI

struct EventFeedCellView: View {
    
    struct UIConstants {
        static let size: CGFloat = 128
        static let bottomTextPanel: CGFloat = 40
        static let fontSize: CGFloat = 11
        static let cornerRadius: CGFloat = 24
        static let textPadding = EdgeInsets(top: -4, leading: 8, bottom: 0, trailing: 8)
        static let maxTextLines: Int = 2
    }
    
    let event: HistoricalEvent
    let tappedAction: ((_ event: HistoricalEvent) -> Void)?
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: event.imageUrl)) { image in
                image.resizable(resizingMode: .stretch)
            } placeholder: {
                Color.cellBackground
            }
            VStack {
                Spacer()
                ZStack(alignment: .leading) {
                    Color.cellTextBackground
                    Text(event.name)
                        .font(.system(size: UIConstants.fontSize))
                        .foregroundColor(.cellTitleFont)
                        .padding(UIConstants.textPadding)
                        .lineLimit(UIConstants.maxTextLines)
                }
                .frame(width: UIConstants.size, height: UIConstants.bottomTextPanel)
            }
        }
        .frame(width: UIConstants.size, height: UIConstants.size, alignment: .center)
        .clipShape(.rect(cornerRadius: UIConstants.cornerRadius))
        .onTapGesture {
            self.tappedAction?(event)
        }
    }
}

struct EventFeedCellView_Previews: PreviewProvider {
    static let event = HistoricalEvent(id: 0, name: "Name", desctiption: "Description", date: Date.now, imageUrl: "https://cdn.tripster.ru/thumbs2/cf69e9ba-f0ea-11ea-beeb-b6b555681a2b.800x600.jpg")
    
    static var previews: some View {
        EventFeedCellView(event: event, tappedAction: nil)
    }
}
