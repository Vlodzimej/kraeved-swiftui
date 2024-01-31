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
    let imageUrls: [URL]?
    let thumbnailUrl: URL?
    let regionId: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, date, imageUrls, thumbnailUrl, regionId
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        imageUrls = try values.decodeIfPresent([URL].self, forKey: .imageUrls)
        thumbnailUrl = try values.decodeIfPresent(URL.self, forKey: .thumbnailUrl)
        regionId = try values.decodeIfPresent(Int.self, forKey: .regionId)
    }
    
    init(id: Int, name: String?, description: String?, date: String?, imageUrls: [URL]?, thumbnailUrl: URL?, regionId: Int?) {
        self.id = id
        self.name = name
        self.description = description
        self.date = date
        self.imageUrls = imageUrls
        self.thumbnailUrl = thumbnailUrl
        self.regionId = regionId
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
