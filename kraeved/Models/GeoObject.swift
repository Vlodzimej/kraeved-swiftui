//
//  GeoObject.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import Foundation

struct GeoObject: Decodable, Equatable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case longitude
        case latitude
        //case type
        case imageUrl
    }
    
    let id: Int
    let name: String
    let description: String
    let longitude: Double
    let latitude: Double
    //let type: GeoObjectType
    let imageUrl: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        longitude = try values.decode(Double.self, forKey: .longitude)
        latitude = try values.decode(Double.self, forKey: .latitude)
        //type = try values.decode(GeoObjectType.self, forKey: .type)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
    }
    
    init(id: Int, name: String, description: String, longitude: Double, latitude: Double, type: GeoObjectType, imageUrl: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.longitude = longitude
        self.latitude = latitude
        //self.type = type
        self.imageUrl = imageUrl
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

enum GeoObjectType: String, Codable {
    case museum      = "MUSEUM"
    case theater     = "THEATER"
    case cinemaHall  = "CINEMA_HALL"
    case concertHall = "CONCERT_HALL"
}
