//
//  HistoricalEventBrief.swift
//  kraeved
//
//  Created by Владимир Амелькин on 24.01.2024.
//

import Foundation

struct HistoricalEventBrief: Decodable, Equatable {
    let id: Int?
    let name: String?
    let thumbnailUrl: URL?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, thumbnailUrl
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        thumbnailUrl = try values.decodeIfPresent(URL.self, forKey: .thumbnailUrl)
    }
    
    init(id: Int? = nil, name: String? = nil, thumbnailUrl: URL? = nil) {
        self.id = id
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
