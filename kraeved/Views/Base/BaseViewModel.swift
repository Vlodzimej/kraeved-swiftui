//
//  BaseViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 20.01.2024.
//

import Foundation

//MARK: - BaseViewModel
@MainActor class BaseViewModel: ObservableObject {
    
    @Published var isShowAlert: Bool = false
    @Published var isLoading: Bool = false
    
    var networkManager: NetworkManager
    var kraevedAPI: KraevedAPI
    
    init(networkManager: NetworkManager = NetworkManager.shared, kraevedAPI: KraevedAPI = KraevedAPI.shared) {
        self.networkManager = networkManager
        self.kraevedAPI = kraevedAPI
    }
}
