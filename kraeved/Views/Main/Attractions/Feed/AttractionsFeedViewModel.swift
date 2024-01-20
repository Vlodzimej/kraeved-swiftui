//
//  AttractionsViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 03.10.2023.
//

import SwiftUI

extension AttractionsFeedView {
    
    //MARK: - ViewModel
    final class ViewModel: BaseViewModel {
                
        //MARK: Properties
        @Published private(set) var attractions: [GeoObjectBrief]?

        //MARK: Public Methods
        func getAttractions(regionId: Int? = nil, name: String? = nil) async {
            isLoading = true
            Task {
                let result = await networkManager.getGeoObjects(regionId: regionId, name: name)
                switch result {
                    case .success(let attractions):
                        self.attractions = attractions
                    case .failure(let error):
                        isShowAlert = true
                        print(error)
                }
            }
        }
    }
}
