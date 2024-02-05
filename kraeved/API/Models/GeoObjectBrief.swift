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
    let type: GenericTypeDto?
    let thumbnailUrl: URL?
    let longitude: Double?
    let latitude: Double?

    init(id: Int? = nil, name: String? = nil, shortDescription: String? = nil, type: GenericTypeDto? = nil, thumbnailUrl: URL? = nil, longitude: Double? = nil, latitude: Double? = nil) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.type = type
        self.thumbnailUrl = thumbnailUrl
        self.longitude = longitude
        self.latitude = latitude
    }
}
