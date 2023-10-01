//
//  AttractionsView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.09.2023.
//

import SwiftUI

struct AttractionsView: View {
    let geoObjects: [GeoObjectBrief]
    let openGeoObject: ((_ id: Int) -> Void)
    
    var body: some View {
        VStack(alignment: .leading) {
            MainTitle(title: "Популярное в городе", image: "titleUnderline2")
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(geoObjects, id: \.id) { geoObject in
                        AttractionsFeedCellView(geoObject: geoObject, tappedAction: { selectedGeoObject in
                            self.openGeoObject(selectedGeoObject.id)
                        })
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
        }
    }
}

#Preview {
    let attractions: [GeoObjectBrief] = [
        .init(id: 0, name: "Тестовый объект", shortDescription: nil, longitude: 0, latitude: 0, imageUrl: nil)
    ]
    
    return AttractionsView(geoObjects: attractions, openGeoObject: { geoObject in
        print(geoObject)
    })
}
