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
    let desctiption: String
    let date: Date
    let imageUrl: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
