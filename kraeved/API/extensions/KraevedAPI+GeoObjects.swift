//
//  KraevedAPI+GeoObjects.swift
//  kraeved
//
//  Created by Владимир Амелькин on 31.01.2024.
//

import Foundation

extension KraevedAPI {
    
    func getGeoObjects(regionId: Int = Constants.defaultRegion, name: String = "") async -> [GeoObjectBrief]? {
        let url = "GeoObjects?regionId=\(regionId)"
        return await networkManager.get(url: url, parameters: nil)
    }
    
    func getGeoObject(id: Int) async -> GeoObject? {
        let url = "GeoObjects/\(id)"
        return await networkManager.get(url: url, parameters: nil)
    }
}
