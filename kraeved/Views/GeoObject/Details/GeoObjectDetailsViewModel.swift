//
//  GeoObjectDetailsViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 04.02.2024.
//

import SwiftUI

//MARK: - GeoObjectDetailsView
extension GeoObjectDetailsView {
    
    final class ViewModel: BaseViewModel {
        //MARK: Properties
        @Published private(set) var geoObject: GeoObject?
        
        //MARK: Public Methods
        func getGeoObject(id: Int) async {
            isLoading = true
            defer {
                isLoading = false
            }
            
            let result = await kraevedAPI.getGeoObject(id: id)
            if case let .success(geoObject) = result {
                self.geoObject = geoObject
            }

        }
    }
}
