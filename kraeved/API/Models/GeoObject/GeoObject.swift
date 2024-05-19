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
        case images
        case thumbnail
    }
    
    let id: Int
    let name: String?
    let description: String?
    let longitude: Double?
    let latitude: Double?
    let type: GenericTypeDto?
    let images: [String]?
    let thumbnail: String?
    
    var thumbnailUrl: URL? {
        URL(string: Settings.instance.baseUrl + "/images/filename/" + (thumbnail ?? ""))
    }
    
    var imageUrls: [URL] {
        images?.compactMap { image in
            URL(string: Settings.instance.baseUrl + "/images/filename/" + (image ?? ""))
        } ?? []
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
//    init(id: Int, name: String?, description: String?, longitude: Double?, latitude: Double?, type: GenericTypeDto?, images: [String]?, thumbnail: String?) {
//        self.id = id
//        self.name = name
//        self.description = description
//        self.longitude = longitude
//        self.latitude = latitude
//        self.type = type
//        self.images = images
//        self.thumbnail = thumbnail
//    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

struct GenericTypeDto: Decodable, Hashable, Equatable {
    var id: Int
    var name: String
    var title: String
}
