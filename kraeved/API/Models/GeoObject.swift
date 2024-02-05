//
//  GeoObject.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import Foundation

struct GeoObject: Decodable, Equatable, Hashable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case longitude
        case latitude
        case type
        case imageUrls
        case thumbnailUrl
    }
    
    let id: Int
    let name: String?
    let description: String?
    let longitude: Double?
    let latitude: Double?
    let type: GenericTypeDto?
    let imageUrls: [URL]?
    let thumbnailUrl: URL?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        type = try values.decode(GenericTypeDto.self, forKey: .type)
        imageUrls = try values.decodeIfPresent([URL].self, forKey: .imageUrls)
        thumbnailUrl = try values.decodeIfPresent(URL.self, forKey: .thumbnailUrl)
    }
    
    init(id: Int, name: String?, description: String?, longitude: Double?, latitude: Double?, type: GenericTypeDto?, imageUrls: [URL]?, thumbnailUrl: URL?) {
        self.id = id
        self.name = name
        self.description = description
        self.longitude = longitude
        self.latitude = latitude
        self.type = type
        self.imageUrls = imageUrls
        self.thumbnailUrl = thumbnailUrl
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

struct GenericTypeDto: Decodable, Hashable, Equatable {
    let id: Int
    let name: String
    let title: String?
}
