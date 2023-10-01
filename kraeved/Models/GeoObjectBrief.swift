//
//  GeoObjectBrief.swift
//  kraeved
//
//  Created by Владимир Амелькин on 01.10.2023.
//

import Foundation

struct GeoObjectBrief: Decodable {
    let id: Int
    let name: String
    let shortDescription: String?
    let longitude: Double?
    let latitude: Double?
    let imageUrl: String?
}
