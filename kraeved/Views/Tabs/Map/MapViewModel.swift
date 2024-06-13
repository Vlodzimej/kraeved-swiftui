//
//  MapViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 31.01.2024.
//

import SwiftUI

//MARK: - MapView
extension MapView {
    
    final class ViewModel: BaseViewModel {
    
        @Published private(set) var geoObjects: [GeoObjectBrief]? 
        
        func getGeoObjects() async {
            geoObjects = await kraevedAPI.getGeoObjects()
        }
        
        func removeGeoObject(by id: Int) async throws {
            try await kraevedAPI.removeGeoObject(id: id)
            geoObjects = geoObjects?.lazy.filter { $0.id != id }
        }
    }
}

