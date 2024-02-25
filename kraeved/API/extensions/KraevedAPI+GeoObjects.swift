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
    
    func getGeoObjectTypes() async -> [GenericType]? {
        let url = "GeoObjectTypes"
        return await networkManager.get(url: url, parameters: nil)
    }
    
    func createGeoObject(name: String, typeId: Int, description: String, latitude: Double, longitude: Double, regionId: Int, imageUrls: [String], thumbnailUrl: String) async throws -> Void {
        let url = "GeoObjects"
        let parameters: [String: Any] = [
            "name"          : name,
            "typeId"        : typeId,
            "description"   : description,
            "latitude"      : latitude,
            "longitude"     : longitude,
            "regionId"      : regionId,
            "imageUrls"     : imageUrls,
            "thumbnailUrl"  : thumbnailUrl
        ]
        return try await networkManager.post(url: url, parameters: parameters)
    }
}
