//
//  GeoObject.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import Foundation

//struct GeoObjectOutDto: Encodable, Equatable {
//    let id: Int?
//    let name: String
//    let description: String
//    let longitude: Double
//    let latitude: Double
//    let type: GenericTypeDto
//    let images: [String]
//    let thumbnail: String
//}

struct GeoObject: Codable, Equatable, Hashable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case longitude
        case latitude
        case type
        case images
        case thumbnail
    }
    
    var id: Int?
    var name: String
    var description: String
    var longitude: Double
    var latitude: Double
    var type: GenericTypeDto
    var images: [String]
    var thumbnail: String
    
    var thumbnailUrl: URL? {
        URL(string: Settings.instance.baseUrl + "/images/filename/" + (thumbnail ?? ""))
    }
    
    var imageUrls: [URL] {
        images.compactMap { image in
            URL(string: Settings.instance.baseUrl + "/images/filename/" + (image ?? ""))
        } ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(type.id, forKey: .type)
        try container.encode(images, forKey: .images)
        try container.encode(thumbnail, forKey: .thumbnail)
    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
//        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
//        type = try values.decode(GenericTypeDto.self, forKey: .type)
//        images = try values.decodeIfPresent([String].self, forKey: .images)
//        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
//    }
//    
    init(id: Int? = nil, name: String = "", description: String = "", longitude: Double = 0, latitude: Double = 0, type: GenericTypeDto = .init(id: 0, name: "", title: ""), images: [String] = [], thumbnail: String = "") {
        self.id = id
        self.name = name
        self.description = description
        self.longitude = longitude
        self.latitude = latitude
        self.type = type
        self.images = images
        self.thumbnail = thumbnail
    }
    
    init(longitude: String, latitude: String) {
        self.init(longitude: Double(longitude) ?? 0, latitude: Double(latitude) ?? 0)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

struct GenericTypeDto: Decodable, Hashable, Equatable {
    var id: Int
    var name: String
    var title: String
}
