//
//  BaseViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 20.01.2024.
//

import Foundation

@MainActor class BaseViewModel: ObservableObject {
    
    @Published var isShowAlert: Bool = false
    @Published var isLoading: Bool = false
    
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
}
