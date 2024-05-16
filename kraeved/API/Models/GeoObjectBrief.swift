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
    let type: GeoObjectType?
    let thumbnail: String
    let longitude: Double?
    let latitude: Double?
    
    var thumbnailUrl: URL? {
        URL(string: Settings.instance.baseUrl + "/images/filename/" + thumbnail)
    }

    init(id: Int? = nil, name: String? = nil, shortDescription: String? = nil, type: GeoObjectType? = nil, thumbnailUrl: String = "", longitude: Double? = nil, latitude: Double? = nil) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.type = type
        self.thumbnail = thumbnailUrl
        self.longitude = longitude
        self.latitude = latitude
    }
}

