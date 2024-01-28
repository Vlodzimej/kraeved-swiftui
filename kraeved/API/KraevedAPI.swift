//
//  KraevedAPI.swift
//  kraeved
//
//  Created by Владимир Амелькин on 28.01.2024.
//

import Foundation

//MARK: - KraevedAPI
class KraevedAPI: ObservableObject, ApplicationLoggerProtocol {
    static let shared = KraevedAPI()
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func getGeoObjects(regionId: Int = Constants.defaultRegion, name: String = "") async -> [GeoObjectBrief]? {
        let url = "GeoObjects?regionId=\(regionId)"
        do {
            let data = try await networkManager.get(url: url, parameters: nil)
            let result: KraevedResponse<[GeoObjectBrief]> = try Self.parseData(data: data)
            return result.data
        }
        catch let error {
            log(label: url, level: .error, message: error.localizedDescription, userInfo: nil)
            return nil
        }
    }
    
    func getGeoObject(id: Int) async -> GeoObject? {
        let url = "GeoObjects/\(id)"
        do {
            let data = try await networkManager.get(url: url, parameters: nil)
            let result: KraevedResponse<GeoObject> = try Self.parseData(data: data)
            return result.data
        }
        catch let error {
            log(label: url, level: .error, message: error.localizedDescription, userInfo: nil)
            return nil
        }
    }
    
    func getHistoricalEvents(regionId: Int = Constants.defaultRegion, name: String = "") async -> [HistoricalEventBrief]? {
        let url = "HistoricalEvents?name=\(name)&regionId=\(regionId)>"
        do {
            let data = try await networkManager.get(url: url, parameters: nil)
            let result: KraevedResponse<[HistoricalEventBrief]> = try Self.parseData(data: data)
            return result.data
        }
        catch let error {
            log(label: url, level: .error, message: error.localizedDescription, userInfo: nil)
            return nil
        }
    }
    
    private static func parseData<T: Decodable>(data: Data) throws -> T{
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
        else {
            throw NSError(
                domain: "NetworkAPIError",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }
        return decodedData
    }
}
