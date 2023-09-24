//
//  GeoObject.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import Foundation

struct GeoObject: Decodable {
    let id: Int
    let name: String
    let description: String
    let longitude: Double
    let latitude: Double
}
