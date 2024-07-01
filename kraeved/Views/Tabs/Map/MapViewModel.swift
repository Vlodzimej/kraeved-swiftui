//
//  MapViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 31.01.2024.
//

import SwiftUI

//MARK: - MapView
extension MapView {

    //MARK: - ViewModel
    final class ViewModel: BaseViewModel {
    
        @Published private(set) var geoObjects: [GeoObjectBrief]? 
        @Published private(set) var currentUserRole: UserRole?
        
        private let userManager: UserManagerProtocol
        private let apiManager: GeoObjectsAPIManagerProtocol

        
        //MARK: Init
        init(userManager: UserManagerProtocol = UserManager.shared, apiManager: GeoObjectsAPIManagerProtocol = KraevedAPIManager.shared) {
            self.userManager = userManager
            self.apiManager = apiManager
        }
        
        //MARK: Public Methods
        func getGeoObjects() async {
            let result = await apiManager.getGeoObjects(regionId: Constants.defaultRegion, name: "")
            if case let .success(geoObjects) = result {
                self.geoObjects = geoObjects
            }
        }
        
        func removeGeoObject(by id: Int) async throws {
            try await apiManager.removeGeoObject(id: id)
            geoObjects = geoObjects?.lazy.filter { $0.id != id }
        }
        
        func getCurrentUserRole() async {
            currentUserRole = await userManager.getCurrentUserRole()
        }
    }
}

