//
//  AttractionsView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.09.2023.
//

import SwiftUI

struct AttractionsView: View {
    let geoObjects: [GeoObject]
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
    let attractions: [GeoObject] = [
        .init(id: 0, name: "Тестовый объект", description: "Описание для тестового объекта", longitude: 0, latitude: 0, type: .museum, imageUrl: nil),
        .init(id: 1, name: "Тестовый объект 2", description: "Описание для тестового объекта", longitude: 0, latitude: 0, type: .museum, imageUrl: nil),
        .init(id: 2, name: "Тестовый объект 3", description: "Описание для тестового объекта", longitude: 0, latitude: 0, type: .museum, imageUrl: nil),
        .init(id: 3, name: "Тестовый объект 4", description: "Описание для тестового объекта", longitude: 0, latitude: 0, type: .museum, imageUrl: nil),
        .init(id: 4, name: "Тестовый объект 5", description: "Описание для тестового объекта", longitude: 0, latitude: 0, type: .museum, imageUrl: nil)
    ]
    
    return AttractionsView(geoObjects: attractions, openGeoObject: { geoObject in
        print(geoObject)
    })
}
