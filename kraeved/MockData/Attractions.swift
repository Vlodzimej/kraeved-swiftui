//
//  Attractions.swift
//  kraeved
//
//  Created by Владимир Амелькин on 01.10.2023.
//

import Foundation

let mockGeoObjects: [GeoObjectBrief] = [
    .init(id: 0, name: String(repeating: "_", count: 16), shortDescription: String(repeating: "_", count: 100), longitude: 0, latitude: 0, imageUrl: nil),
    .init(id: 0, name: String(repeating: "_", count: 16), shortDescription: String(repeating: "_", count: 100), longitude: 0, latitude: 0, imageUrl: nil),
    .init(id: 0, name: String(repeating: "_", count: 16), shortDescription: String(repeating: "_", count: 100), longitude: 0, latitude: 0, imageUrl: nil),
    .init(id: 0, name: String(repeating: "_", count: 16), shortDescription: String(repeating: "_", count: 100), longitude: 0, latitude: 0, imageUrl: nil),
    .init(id: 0, name: String(repeating: "_", count: 16), shortDescription: String(repeating: "_", count: 100), longitude: 0, latitude: 0, imageUrl: nil),
    .init(id: 0, name: String(repeating: "_", count: 16), shortDescription: String(repeating: "_", count: 100), longitude: 0, latitude: 0, imageUrl: nil),
    .init(id: 0, name: String(repeating: "_", count: 16), shortDescription: String(repeating: "_", count: 100), longitude: 0, latitude: 0, imageUrl: nil),
    .init(id: 0, name: String(repeating: "_", count: 16), shortDescription: String(repeating: "_", count: 100), longitude: 0, latitude: 0, imageUrl: nil),
    .init(id: 0, name: String(repeating: "_", count: 16), shortDescription: String(repeating: "_", count: 100), longitude: 0, latitude: 0, imageUrl: nil)
]

let mockGeoObject = GeoObject(id: 5, 
                              name: "Кинотеатр «Центральный»",
                              description: "Кинотеатр был открыт 1 января 1935 года. В 1984 г. с северо-востока был пристроен крупный «красный» зрительский зал, возведены другие пристройки, частично изменены фасады. В 2000 году были проведены работы по реконструкции и обновлению залов. Сегодня кинотеатр — современный комплекс, в котором есть все для приятного и интересного семейного отдыха.",
                              longitude: 0,
                              latitude: 0,
                              type: .cinemaHall, 
                              imageUrl: nil)
