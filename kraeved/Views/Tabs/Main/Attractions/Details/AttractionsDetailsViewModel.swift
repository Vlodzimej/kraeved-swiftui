//
//  AttractionsDetailsViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 18.01.2024.
//

import SwiftUI

//MARK: - AttractionsDetailsView
extension AttractionsDetailsView {
    
    //MARK: - ViewModel
    final class ViewModel: BaseViewModel {
        
        //MARK: Properties
        @Published private(set) var attraction: GeoObject?
        
        //MARK: Public Methods
        func getAttraction(id: Int) async {
            guard attraction == nil else { return }
            let result = await kraevedAPI.getGeoObject(id: id)
            if case let .success(geoObject) = result {
                attraction = geoObject
            }
        }
    }
}
