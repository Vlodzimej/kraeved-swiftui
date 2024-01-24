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
        func getAttractions() async {
            isLoading = true
            Task {
                let result = await networkManager.getGeoObjects()
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
