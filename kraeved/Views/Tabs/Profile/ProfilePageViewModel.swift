//
//  ProfilePageViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 29.06.2024.
//

import Foundation

extension ProfilePageView {
    
    final class ViewModel: BaseViewModel {
        
        @Published var isAuth: Bool = false
        @Published var editedUser = User()
        private var initialUser = User()
        
        var hasChanges: Bool {
            initialUser != editedUser
        }
        
        private let authManager: AuthManagerProtocol
        private let apiManager: UserAPIManagerProtocol
        
        init(authManager: AuthManagerProtocol = AuthManager.shared, apiManager: UserAPIManagerProtocol = KraevedAPIManager.shared) {
            self.isAuth = UserDefaults.standard.bool(forKey: "isAuth")
            self.authManager = authManager
            self.apiManager = apiManager
        }
        
        func logout() {
            isLoading = true
            defer { isLoading = false }
            
            authManager.logout()
            isAuth = false
        }
        
        func getCurrentUser() {
            isLoading = true
            defer { isLoading = false }
            
            Task {
                let result  = await apiManager.getCurrentUser()
                switch result {
                    case .success(let user):
                        isAuth = true
                        initialUser = user
                        editedUser = user
                    case .failure(let error):
                        authManager.logout()
                        isAuth = false
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
        
        func updateAuthStatus() {
            isAuth = authManager.getUserPhone() != nil
        }
    }
}
