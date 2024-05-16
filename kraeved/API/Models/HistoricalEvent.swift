//
//  HistoricalEvent.swift
//  kraeved
//
//  Created by Владимир Амелькин on 24.09.2023.
//

import Foundation

struct HistoricalEvent: Decodable, Equatable {
    let id: Int
    let name: String?
    let description: String?
    let date: String?
    let images: [String]?
    let thumbnail: String?
    let regionId: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, date, images, thumbnail, regionId
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        regionId = try values.decodeIfPresent(Int.self, forKey: .regionId)
    }
    
    init(id: Int, name: String?, description: String?, date: String?, images: [String]?, thumbnail: String?, regionId: Int?) {
        self.id = id
        self.name = name
        self.description = description
        self.date = date
        self.images = images
        self.thumbnail = thumbnail
        self.regionId = regionId
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
