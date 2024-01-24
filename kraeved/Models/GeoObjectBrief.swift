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
    let thumbnailUrl: URL?

    init(id: Int? = nil, name: String? = nil, shortDescription: String? = nil, thumbnailUrl: URL? = nil) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.thumbnailUrl = thumbnailUrl
    }
}
