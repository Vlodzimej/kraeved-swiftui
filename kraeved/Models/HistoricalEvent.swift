//
//  HistoricalEvent.swift
//  kraeved
//
//  Created by Владимир Амелькин on 24.09.2023.
//

import Foundation

struct HistoricalEvent: Decodable, Equatable {
    let id: Int
    let name: String
    let description: String
    let date: Date
    let imageUrls: [URL]?
    let thumbnailUrl: URL?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, date, imageUrls, thumbnailUrl
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        date = try values.decode(Date.self, forKey: .date)
        imageUrls = try values.decodeIfPresent([URL].self, forKey: .imageUrls)
        thumbnailUrl = try values.decodeIfPresent(URL.self, forKey: .thumbnailUrl)
    }
    
    init(id: Int, name: String, description: String, date: Date, imageUrls: [URL]?, thumbnailUrl: URL? ) {
        self.id = id
        self.name = name
        self.description = description
        self.date = date
        self.imageUrls = imageUrls
        self.thumbnailUrl = thumbnailUrl
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
