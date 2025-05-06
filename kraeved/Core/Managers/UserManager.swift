//
//  UserManager.swift
//  kraeved
//
//  Created by Владимир Амелькин on 01.07.2024.
//

import Foundation

//MARK: - UserManagerProtocol
protocol UserManagerProtocol {
    func getCurrentUserRole() async -> UserRole
}

//MARK: - UserManager
final class UserManager: UserManagerProtocol {
    
    static let shared = UserManager()
    
    //MARK: Properties
    private let securityManager: SecurityManagerProtocol
    private let apiManager: UserAPIManagerProtocol
    private let networkManager: NetworkManagerProtocol
    
    //MARK: Init
    init(securityManager: SecurityManagerProtocol = SecurityManager.shared,
         apiManager: UserAPIManagerProtocol = KraevedAPIManager.shared,
         networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.securityManager = securityManager
        self.apiManager = apiManager
        self.networkManager = networkManager
    }
    
    //MARK: Public Methods
    func getCurrentUserRole() async -> UserRole {
        if let role = UserDefaults.standard.string(forKey: "currentUserRole") {
            return UserRole(rawValue: role) ?? .unknown
        }
        
        let result = await apiManager.getCurrentUser()
        if case let .success(user) = result {
            UserDefaults.standard.setValue(user.role.rawValue, forKey: "currentUserRole")
            return user.role
        }
        
        return .unknown
    }
}
