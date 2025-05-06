//
//  AuthManager.swift
//  kraeved
//
//  Created by Владимир Амелькин on 06.05.2025.
//

import Foundation

//MARK: - AuthManagerProtocol
protocol AuthManagerProtocol {
    func logout()
    func register(email: String, password: String) async
    func login(email: String, password: String) async -> Bool
    func getUserPhone() -> String?
}
//MARK: - AuthManager
final class AuthManager: AuthManagerProtocol {
    
    static let shared = AuthManager()
    
    //MARK: Properties
    private let securityManager: SecurityManagerProtocol
    private let apiManager: AuthAPIManagerProtocol
    private let networkManager: NetworkManagerProtocol
    
    //MARK: Init
    init(securityManager: SecurityManagerProtocol = SecurityManager.shared,
         apiManager: AuthAPIManagerProtocol = KraevedAPIManager.shared,
         networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.securityManager = securityManager
        self.apiManager = apiManager
        self.networkManager = networkManager
    }
    
    //MARK: Public Methods
    func logout() {
        guard let phone = UserDefaults.standard.string(forKey: "userPhone") else { return }
        
        securityManager.deletePassword(service: Settings.instance.currentEnvironment.rawValue, account: phone)
        securityManager.deleteToken(service: Settings.instance.currentEnvironment.rawValue, account: phone)
        
        networkManager.removeAuthorizationToken()
        
        UserDefaults.standard.removeObject(forKey: "isAuth")
        UserDefaults.standard.removeObject(forKey: "userPhone")
        UserDefaults.standard.removeObject(forKey: "currentUserRole")
    }
    
    func register(email: String, password: String) async {
        let result = await apiManager.register(email: email, password: password)
        switch result {
            case .success(let userDto):
                print("CHECK", userDto)
            case .failure(let error):
                print("CHECK", error)
        }
    }
    
    func login(email: String, password: String) async -> Bool {
        let loginDto = await apiManager.login(email: email, password: password)
        switch loginDto {
            case .success(let loginDto):
                handleLoginResponse(email: email, token: loginDto.token)
                return true
            case .failure(let error):
                //errorMessage = error.localizedDescription
                return false
        }
        return false
    }
    
    func handleLoginResponse(email: String, token: String?) -> Bool {
        guard let token, securityManager.saveToken(service: Settings.instance.currentEnvironment.rawValue,
                                                   account: email,
                                                   token: token) else { return false }
        
        UserDefaults.standard.setValue(true, forKey: "isAuth")
        UserDefaults.standard.setValue(email, forKey: "userPhone")
        
        networkManager.updateAuthorizationToken()
        return true
    }
    
    func getUserPhone() -> String? {
        guard let phone = UserDefaults.standard.string(forKey: "userPhone") else { return nil }
        return phone
    }
}
