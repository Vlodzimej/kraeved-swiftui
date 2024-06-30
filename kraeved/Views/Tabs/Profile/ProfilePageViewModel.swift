//
//  ProfilePageViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 29.06.2024.
//

import Foundation

extension ProfilePageView {
    
    final class ViewModel: BaseViewModel {
        
        @Published var editedUser = User()
        private var initialUser = User()
        
        var hasChanges: Bool {
            initialUser != editedUser
        }
        
        private let securityManager: SecurityManagerProtocol
        private let apiManager: UserAPIManagerProtocol
        
        init(securityManager: SecurityManagerProtocol = SecurityManager.shared, apiManager: UserAPIManagerProtocol = KraevedAPIManager.shared) {
            self.securityManager = securityManager
            self.apiManager = apiManager
        }
        
        func logout() {
            isLoading = true
            defer { isLoading = false }
            
            guard let phone = UserDefaults.standard.string(forKey: "userPhone") else { return }
            
            securityManager.deletePassword(service: Settings.instance.currentEnvironment.rawValue, account: phone)
            securityManager.deleteToken(service: Settings.instance.currentEnvironment.rawValue, account: phone)
            
            UserDefaults.standard.removeObject(forKey: "isAuth")
            UserDefaults.standard.removeObject(forKey: "userPhone")
        }
        
        func getCurrentUser() {
            isLoading = true
            defer { isLoading = false }
            
            Task {
                let result  = await apiManager.getCurrentUser()
                switch result {
                    case .success(let user):
                        initialUser = user
                        editedUser = user
                    case .failure(let error):
                        debugPrint(error)
                }
            }
        }
        
        func patchCurrentUser() {
            isLoading = true
            defer { isLoading = false }
            
            Task {
                let user = UserOutDto(name: initialUser.name != editedUser.name ? editedUser.name : nil,
                                      surname:  initialUser.surname != editedUser.surname ? editedUser.surname : nil)
                let result = await apiManager.patchCurrentUser(user: user)
                switch result {
                    case .success(let user):
                        initialUser = user
                        editedUser = user
                    case .failure(let error):
                        debugPrint(error)
                }
            }
        }
    }
}
