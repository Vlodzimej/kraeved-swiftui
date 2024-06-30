//
//  KraevedAPI+HistoricalEvents.swift
//  kraeved
//
//  Created by Владимир Амелькин on 31.01.2024.
//

import Foundation

protocol HistoricalEventAPIManager {
    func getHistoricalEvents(regionId: Int, name: String) async -> [HistoricalEventBrief]?
    func getHistoricalEvent(id: Int) async -> HistoricalEvent?
}

extension KraevedAPIManager: HistoricalEventAPIManager {
    
    func getHistoricalEvents(regionId: Int = Constants.defaultRegion, name: String = "") async -> [HistoricalEventBrief]? {
        let url = "HistoricalEvents?name=\(name)&regionId=\(regionId)>"
        return await networkManager.get(url: url, parameters: nil) 
    }
    
    func getHistoricalEvent(id: Int) async -> HistoricalEvent? {
        let url = "HistoricalEvents/\(id)"
        return await networkManager.get(url: url, parameters: nil)
    }
    
}
