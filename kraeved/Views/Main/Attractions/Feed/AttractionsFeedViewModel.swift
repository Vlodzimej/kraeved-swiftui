//
//  AttractionsViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 03.10.2023.
//

import SwiftUI

extension AttractionsFeedView {
    @MainActor class ViewModel: ObservableObject {
        
        private var networkManager: NetworkManager?
        
        @Published private(set) var attractions: [GeoObjectBrief] = mockGeoObjects
        @Published private(set) var attraction: GeoObject?
        
        func setup(_ networkManager: NetworkManager) {
            self.networkManager = networkManager
        }
        
        func getAttractions(regionId: Int? = nil, name: String? = nil) async {
            let result = await networkManager?.getGeoObjects(regionId: regionId, name: name)
            switch result {
                case .success(let attractions):
                    self.attractions = attractions
                case .failure(let error):
                    break
                case .none:
                    break
            }
        }
        
        func getAttraction(id: Int) async {
            let result = await networkManager?.getGeoObject(id: id)
            switch result {
                case .success(let attraction):
                    self.attraction = attraction
                case .none:
                    break
                case .failure(let error):
                    break
            }
        }
    }
}
