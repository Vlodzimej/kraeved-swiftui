//
//  GeoObjectType.swift
//  kraeved
//
//  Created by Владимир Амелькин on 13.02.2024.
//

import SwiftUI

enum GeoObjectType: String, Decodable {
    case museum      = "MUSEUM"
    case theater     = "THEATER"
    case cinema      = "CINEMA"
    case concertHall = "CONCERT_HALL"
    case unknown     = "UNKNOWN"
    
    var icon: Image {
        switch self {
            case .museum:
                Image("map_icon_museum")
            case .theater:
                Image("map_icon_theatre")
            case .cinema:
                Image("map_icon_cinema")
            case .concertHall:
                Image("map_icon_concertHall")
            case .unknown:
                Image("map_icon_unknown")
        }
    }
}

struct GenericType: Codable, Identifiable {
    let id: Int
    let name: String
    let title: String
}
