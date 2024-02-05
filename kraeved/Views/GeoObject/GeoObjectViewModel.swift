//
//  GeoObjectViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 04.02.2024.
//

import SwiftUI

//MARK: - GeoObjectView
extension GeoObjectView {
    
    final class ViewModel: BaseViewModel {
        //MARK: Properties
        @Published private(set) var geoObject: GeoObject?
        
        //MARK: Public Methods
        func getGeoObject(id: Int) async {
            let test = await kraevedAPI.getGeoObject(id: id)
            geoObject = test
        }
    }
}
