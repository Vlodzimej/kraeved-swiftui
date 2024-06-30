//
//  KraevedAPI+Auth.swift
//  kraeved
//
//  Created by Владимир Амелькин on 29.06.2024.
//

import Foundation

//MARK: - AuthAPIManagerProtocol
protocol AuthAPIManagerProtocol {
    func sendPhone(phone: String) async -> Result<Bool, Error>
    func sendCode(phone: String, code: String) async -> Result<LoginInDto, Error>
    func login(phone: String, password: String) async -> Result<LoginInDto, Error>
}

extension KraevedAPIManager: AuthAPIManagerProtocol{
    
    func sendPhone(phone: String) async -> Result<Bool, Error> {
        let url = "auth?phone=\(phone)"
        return await networkManager.request(url: url, method: .post, parameters: nil)
    }
    
    func sendCode(phone: String, code: String) async -> Result<LoginInDto, Error> {
        let url = "auth/login"
        let parameters: [String: Any] = [
            "phone" : phone,
            "code"  : code
        ]
        return await networkManager.request(url: url, method: .post, parameters: parameters)
    }
    
    func login(phone: String, password: String) async -> Result<LoginInDto, Error> {
        let url = "auth/login"
        let parameters: [String: Any] = [
            "phone" : phone,
            "password"  : password
        ]
        return await networkManager.request(url: url, method: .post, parameters: parameters)
    }
}
