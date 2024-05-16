//
//  URLCache+imageCache.swift
//  kraeved
//
//  Created by Владимир Амелькин on 16.05.2024.
//

import Foundation

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
