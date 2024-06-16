//
//  GeoObjectFormViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 25.02.2024.
//

import Foundation
import SwiftUI
import UIKit

//MARK: - GeoObjectFormView
extension GeoObjectFormView {
    
    //MARK: - ViewModel
    final class ViewModel: BaseViewModel {
        
        enum GeoObjectMethod {
            case post, put
        }
        
        var initialGeoObject: GeoObject?
        var mode: GeoObjectFormMode = .creation
        var hasChanges: Bool {
            initialGeoObject != editedGeoObject
        }
        
        @Published var types: [GenericType]?
        @Published var editedGeoObject = GeoObject()
        @Published var typeId: Int = 0
        
        func submit(thumbnailImage: Image?, images: [UIImage]) async throws {
            isLoading = true
            do {
                try await sendGeoObject(thumbnailImage: thumbnailImage, photoImages: images)
                isLoading = false
            }
            catch {
                isLoading = false
            }
        }
        
        func fetchGeoObjectTypes() async {
            types = await kraevedAPI.getGeoObjectTypes()
        }
        
        private func sendGeoObject(thumbnailImage: Image?, photoImages: [UIImage] = []) async throws {
            do {
                let thumbnail = try await upload(thumbnailImage: thumbnailImage)
                let uploadedImages = try await upload(photoImages: photoImages)
                
                let images = editedGeoObject.images + (uploadedImages ?? [])
                
                let request = switch mode {
                    case .creation:
                        kraevedAPI.createGeoObject
                    case .edit:
                        kraevedAPI.updateGeoObject
                }
                
                try await request(editedGeoObject, typeId, images, thumbnail)
            }
        }
        
        private func upload(thumbnailImage: Image?) async throws -> String? {
            guard let image = thumbnailImage?.asUIImage() else { return nil }
            return try await networkManager.upload(images: [image]).first 
        }
        
        private func upload(photoImages: [UIImage]?) async throws -> [String]? {
            guard let photoImages, !photoImages.isEmpty else { return nil }
            return try await self.networkManager.upload(images: photoImages)
        }
    }
}
