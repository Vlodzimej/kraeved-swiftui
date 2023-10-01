//
//  AttractionCellView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.09.2023.
//

import SwiftUI

struct AttractionsFeedCellView: View {
    let geoObject: GeoObjectBrief
    let tappedAction: ((_ geoObject: GeoObjectBrief) -> Void)?
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.Kraeved.cellBackground
            HStack(alignment: .top, spacing: 12) {
                Image("kaluga1")
                    .resizable()
                    .frame(width: 72, height: 72)
                    .aspectRatio(contentMode: .fill)
                    .border(Color.red)
                    
                    .clipShape(
                        .rect(cornerRadius: 24)
                    )
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                Text(geoObject.name)
                    .font(.system(size: 13))
                    .lineLimit(2)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .frame(height: 90)

        .clipShape(
            .rect(cornerRadius: 24)
        )
        .onTapGesture {
            self.tappedAction?(geoObject)
        }
    }
}

struct AttractionsFeedCellView_Previews: PreviewProvider {
    static let geoObject = GeoObjectBrief(id: 0, name: "Тестовый объект", shortDescription: nil, longitude: 0, latitude: 0, imageUrl: nil)
    static var previews: some View {
        AttractionsFeedCellView(geoObject: geoObject, tappedAction: { geoObject in
            print(geoObject)
        })
    }
}
