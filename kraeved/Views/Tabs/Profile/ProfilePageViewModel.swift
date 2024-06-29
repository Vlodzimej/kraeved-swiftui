//
//  ProfilePageViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 29.06.2024.
//

import Foundation

extension ProfilePageView {
    
    final class ViewModel: BaseViewModel {
        
        private let securityManager: SecurityManagerProtocol
        
        init(securityManager: SecurityManagerProtocol = SecurityManager.shared) {
            self.securityManager = securityManager
        }
        
        func logout() {
            guard let phone = UserDefaults.standard.string(forKey: "userPhone") else { return }
            
            securityManager.deletePassword(service: Settings.instance.currentEnvironment.rawValue, account: phone)
            securityManager.deleteToken(service: Settings.instance.currentEnvironment.rawValue, account: phone)
            
            UserDefaults.standard.removeObject(forKey: "isAuth")
            UserDefaults.standard.removeObject(forKey: "userPhone")
            
            let test = UserDefaults.standard.bool(forKey: "isAuth")
            print("CHECK isAUth", test)
        }
    }
}
