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
            let result = await networkManager.getGeoObject(id: id)
            switch result {
                case .success(let attraction):
                    await MainActor.run {
                        self.attraction = attraction
                    }
                case .failure(let error):
                    break
            }
        }
    }
}
