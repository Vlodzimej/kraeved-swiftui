//
//  GeoObjectFormViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 25.02.2024.
//

import Foundation

//MARK: - GeoObjectFormView
extension GeoObjectFormView {
    
    //MARK: - ViewModel
    final class ViewModel: BaseViewModel {
        
        var mode: GeoObjectFormMode = .creation
        
        @Published var name: String = ""
        @Published var typeId: Int = 0
        @Published var description: String = ""
        @Published var regionId: Int = 40
        @Published var imageUrls: [String] = []
        @Published var thumbnailUrl: String = ""
        @Published var types: [GenericType]?
        
        var latitude: String = ""
        var longitude: String = ""
        
        func submit(latitude: String, longitude: String) {
            self.latitude = latitude
            self.longitude = longitude
            
            switch mode {
                case .creation:
                    createGeoObject()
                case .edit:
                    updateGeoObject()
            }
        }
        
        func fetchGeoObjectTypes() async {
            types = await kraevedAPI.getGeoObjectTypes()
        }
        
        private func createGeoObject() {
            Task {
                do {
                    try await kraevedAPI.createGeoObject(
                        name: name,
                        typeId: typeId,
                        description: description,
                        latitude: Double(latitude) ?? 0,
                        longitude: Double(longitude) ?? 0,
                        regionId: regionId,
                        imageUrls: imageUrls,
                        thumbnailUrl: thumbnailUrl
                    )
                    isShowAlert = true
                }
            }
        }
        
        private func updateGeoObject() {
            
        }
    }
}
