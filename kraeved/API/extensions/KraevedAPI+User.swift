//
//  KraevedAPI+User.swift
//  kraeved
//
//  Created by Владимир Амелькин on 30.06.2024.
//

import Foundation

// MARK: - UserAPIManagerProtocol
protocol UserAPIManagerProtocol {
    func getCurrentUser() async -> Result<User, Error>
    func patchCurrentUser(user: UserOutDto) async -> Result<User, Error>
}

extension KraevedAPIManager: UserAPIManagerProtocol {
    
    func getCurrentUser() async -> Result<User, Error> {
        let url = "users/current"
        return await networkManager.request(url: url, method: .get, parameters: nil)
    }
    
    func patchCurrentUser(user: UserOutDto) async -> Result<User, Error> {
        let url = "users/current"
        var parameters: [String: Any] = [:]
        
        if let name = user.name {
            parameters["name"] = name
        }
        
        if let surname = user.surname {
            parameters["surname"] = surname
        }
        
        return await networkManager.request(url: url, method: .patch, parameters: parameters)
    }
}
