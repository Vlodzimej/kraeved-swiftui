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
    
    func createGeoObject(geoObject: GeoObject, typeId: Int, images: [String]?, thumbnail: String?) async throws -> Void {
        let url = "GeoObjects"
        let parameters: [String: Any] = [
            "name"          : geoObject.name,
            "typeId"        : typeId,
            "description"   : geoObject.description,
            "latitude"      : geoObject.latitude,
            "longitude"     : geoObject.longitude,
            "regionId"      : 40,
            "images"        : images ?? geoObject.images,
            "thumbnail"     : thumbnail ?? geoObject.thumbnail
        ]
        return try await networkManager.requestStatus(url: url, method: .post, parameters: parameters)
    }
    
    func updateGeoObject(geoObject: GeoObject, typeId: Int, images: [String]?, thumbnail: String?) async throws -> Void {
        let url = "GeoObjects"
        var parameters: [String: Any] = [
            "name"          : geoObject.name,
            "typeId"        : typeId,
            "description"   : geoObject.description,
            "latitude"      : geoObject.latitude,
            "longitude"     : geoObject.longitude,
            "regionId"      : 40,
            "images"        : images ?? geoObject.images,
            "thumbnail"     : thumbnail ?? geoObject.thumbnail
        ]
        if let id = geoObject.id {
            parameters["id"] = id
        }
        
        return try await networkManager.requestStatus(url: url, method: .put, parameters: parameters)
    }
    
    func removeGeoObject(id: Int) async throws -> Void {
        let url = "GeoObjects/\(id)"
        return try await networkManager.requestStatus(url: url, method: .delete, parameters: nil)
    }
}
