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
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    

}
