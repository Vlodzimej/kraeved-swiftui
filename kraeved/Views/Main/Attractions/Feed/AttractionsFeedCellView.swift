//
//  AttractionCellView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.09.2023.
//

import SwiftUI

struct AttractionsFeedCellView: View {
    let geoObject: GeoObjectBrief
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.Kraeved.cellBackground
            HStack(alignment: .top) {
                Image("kaluga1")
                    .resizable()
                    .frame(width: 72, height: 72)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(
                        .rect(cornerRadius: 14)
                    )
                VStack(alignment: .leading, spacing: 0) {
                    Text(geoObject.name)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.Kraeved.cellTitleFont)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 3)
                    Text(geoObject.shortDescription ?? "")
                        .font(.system(size: 10))
                        .foregroundStyle(Color.Kraeved.cellTitleFont)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 16))
        }
        .frame(height: 90)

        .clipShape(
            .rect(cornerRadius: 18)
        )
        .shadow(radius: 1)
        .background(.clear)
        .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
    }
}

struct AttractionsFeedCellView_Previews: PreviewProvider {
    static let geoObject = GeoObjectBrief(id: 0, name: "Дом народного творчества и кино Центральный", shortDescription: "Здание кинотеатра «Центральный» было построено в 1935 году. Проектирование и строительство велось 5 лет, начиная с 1930 года. Это было первое специальное здание для кинотеатра в Калуге. Автор проекта — архитектор Госкино Михаил Черкасов. На торжественное открытие кинотеатра приезжал Семён Будённый.", longitude: 0, latitude: 0, imageUrl: nil)
    static var previews: some View {
        AttractionsFeedCellView(geoObject: geoObject)
    }
}
