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
    @Published var errorMessage: String?
    
    var networkManager: NetworkManager
    var kraevedAPI: KraevedAPIManager
    
    init(networkManager: NetworkManager = NetworkManager.shared, kraevedAPI: KraevedAPIManager = KraevedAPIManager.shared) {
        self.networkManager = networkManager
        self.kraevedAPI = kraevedAPI
    }
}
