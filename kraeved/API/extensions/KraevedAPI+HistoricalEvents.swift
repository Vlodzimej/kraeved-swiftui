//
//  KraevedAPI+HistoricalEvents.swift
//  kraeved
//
//  Created by Владимир Амелькин on 31.01.2024.
//

import Foundation

protocol HistoricalEventAPIManager {
    func getHistoricalEvents(regionId: Int, name: String) async -> Result<[HistoricalEventBrief], Error>
    func getHistoricalEvent(id: Int) async -> Result<HistoricalEvent, Error>
}

extension KraevedAPIManager: HistoricalEventAPIManager {
    
    func getHistoricalEvents(regionId: Int = Constants.defaultRegion, name: String = "") async -> Result<[HistoricalEventBrief], Error> {
        let url = "HistoricalEvents?name=\(name)&regionId=\(regionId)>"
        return await networkManager.request(url: url, method: .get, parameters: nil)
    }
    
    func getHistoricalEvent(id: Int) async -> Result<HistoricalEvent, Error> {
        let url = "HistoricalEvents/\(id)"
        return await networkManager.request(url: url, method: .get, parameters: nil)
    }
    
}
