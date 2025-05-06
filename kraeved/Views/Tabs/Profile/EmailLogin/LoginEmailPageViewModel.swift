//
//  LoginEmailPageViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 05.05.2025.
//

import Foundation

extension LoginEmailPageView {
    
    final class ViewModel: BaseViewModel {
        
        @Published var email: String = ""
        @Published var password: String = ""
        
        private let authManager: AuthManagerProtocol
        
        init(authManager: AuthManagerProtocol = AuthManager.shared) {
            self.authManager = authManager
        }
        
        func login() async -> Bool {
            isLoading = true
            defer { isLoading = false }
                
            return await authManager.login(email: email, password: password)
        }
        
        func register() {
            Task {
                isLoading = true
                defer { isLoading = false }
                
                let result = await authManager.register(email: email, password: password)
            }
        }
    }
}
