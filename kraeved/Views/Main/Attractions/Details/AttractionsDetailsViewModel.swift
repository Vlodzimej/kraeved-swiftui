//
//  AttractionsDetailsViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 18.01.2024.
//

import SwiftUI

extension AttractionsDetailsView {
    
    //MARK: - ViewModel
    final class ViewModel: BaseViewModel {
        
        //MARK: Properties
        @Published private(set) var attraction: GeoObject?
        
        //MARK: Public Methods
        func getAttraction(id: Int) async {
            attraction = await kraevedAPI.getGeoObject(id: id)
        }
    }
}
