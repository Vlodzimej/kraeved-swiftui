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
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: event.imageUrl)) { phase in
                switch phase {
                case .empty:
                    EmptyView()
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(maxWidth: 128, maxHeight: 128)
                case .failure:
                    ZStack {
                        Color.Kraeved.cellBackground
                        Image(systemName: "photo")
                    }

                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
                
                //image.resizable(resizingMode: .stretch)
            }
            VStack {
                Spacer()
                ZStack(alignment: .center) {
                    Color.Kraeved.cellTextBackground
                    Text(event.name)
                        .font(.system(size: UIConstants.fontSize))
                        .foregroundColor(Color.Kraeved.cellTitleFont)
                        .padding(UIConstants.textPadding)
                        .lineLimit(UIConstants.maxTextLines)
                }
                .frame(width: UIConstants.size, height: UIConstants.bottomTextPanel)
            }
        }
        .frame(width: UIConstants.size, height: UIConstants.size, alignment: .center)
        .clipShape(
            RoundedRectangle(cornerRadius: UIConstants.cornerRadius)
        )
        .shadow(radius: 2)
    }
}

struct EventFeedCellView_Previews: PreviewProvider {
    static let event = HistoricalEvent(id: 0, name: "Name", desctiption: "Description", date: Date.now, imageUrl: "kaluga1")
    
    static var previews: some View {
        EventFeedCellView(event: event)
    }
}
