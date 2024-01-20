//
//  GeoObjectBrief.swift
//  kraeved
//
//  Created by Владимир Амелькин on 01.10.2023.
//

import Foundation

struct GeoObjectBrief: Decodable, Identifiable, Hashable {
    let id: Int?
    let name: String?
    let shortDescription: String?
    let longitude: Double?
    let latitude: Double?
    let imageUrl: String?
    
    init(id: Int? = nil, name: String? = nil, shortDescription: String? = nil, longitude: Double? = nil, latitude: Double? = nil, imageUrl: String? = nil) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.longitude = longitude
        self.latitude = latitude
        self.imageUrl = imageUrl
    }
}
