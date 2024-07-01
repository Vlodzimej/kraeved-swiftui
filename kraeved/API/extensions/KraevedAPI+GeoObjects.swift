//
//  KraevedAPI+GeoObjects.swift
//  kraeved
//
//  Created by Владимир Амелькин on 31.01.2024.
//

import Foundation

//MARK: - GeoObjectsAPIManagerProtocol
protocol GeoObjectsAPIManagerProtocol {
    func getGeoObjects(regionId: Int, name: String) async -> Result<[GeoObjectBrief], Error>
    func getGeoObject(id: Int) async -> Result<GeoObject, Error>
    func getGeoObjectTypes() async -> Result<[GenericType], Error>
    func createGeoObject(geoObject: GeoObject, typeId: Int, images: [String]?, thumbnail: String?) async throws -> Void
    func updateGeoObject(geoObject: GeoObject, typeId: Int, images: [String]?, thumbnail: String?) async throws -> Void
    func removeGeoObject(id: Int) async throws -> Void
}

extension KraevedAPIManager: GeoObjectsAPIManagerProtocol {
    
    func getGeoObjects(regionId: Int = Constants.defaultRegion, name: String = "") async -> Result<[GeoObjectBrief], Error> {
        let url = "GeoObjects?regionId=\(regionId)"
        return await networkManager.request(url: url, method: .get, parameters: nil)
    }
    
    func getGeoObject(id: Int) async -> Result<GeoObject, Error> {
        let url = "GeoObjects/\(id)"
        return await networkManager.request(url: url, method: .get, parameters: nil)
    }
    
    func getGeoObjectTypes() async -> Result<[GenericType], Error> {
        let url = "GeoObjectTypes"
        return await networkManager.request(url: url, method: .get, parameters: nil)
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
