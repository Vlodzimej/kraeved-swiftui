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
    func logout()
}
//MARK: - UserManager
final class UserManager: UserManagerProtocol {
    
    static let shared = UserManager()
    
    //MARK: Properties
    private let securityManager: SecurityManagerProtocol
    private let apiManager: UserAPIManagerProtocol
    
    //MARK: Init
    init(securityManager: SecurityManagerProtocol = SecurityManager.shared,
         apiManager: UserAPIManagerProtocol = KraevedAPIManager.shared) {
        self.securityManager = securityManager
        self.apiManager = apiManager
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
    
    func logout() {
        guard let phone = UserDefaults.standard.string(forKey: "userPhone") else { return }
        
        securityManager.deletePassword(service: Settings.instance.currentEnvironment.rawValue, account: phone)
        securityManager.deleteToken(service: Settings.instance.currentEnvironment.rawValue, account: phone)
        
        UserDefaults.standard.removeObject(forKey: "isAuth")
        UserDefaults.standard.removeObject(forKey: "userPhone")
        UserDefaults.standard.removeObject(forKey: "currentUserRole")
    }
}
