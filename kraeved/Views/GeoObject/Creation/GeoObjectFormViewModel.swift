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
        
        var initialGeoObject: GeoObject?
        var mode: GeoObjectFormMode = .creation
        var typeId: Int = 0
        
        @Published var types: [GenericType]?
        @Published var editedGeoObject = GeoObject()
        
        func submit(thumbnail: UploadImageState, images: [UIImage]) {
            var thumbnailImage: Image?
            
            if case let .success(image) = thumbnail {
                thumbnailImage = image
            }
            
            Task {
                isLoading = true
                do {
                    switch mode {
                        case .creation:
                            try await createGeoObject(thumbnailImage: thumbnailImage, photoImages: images)
                        case .edit: 
                            try await updateGeoObject(thumbnailImage: thumbnailImage, photoImages: images)
                    }
                    isLoading = false
                }
                catch(let error) {
                    debugPrint(error)
                    isLoading = false
                }
            }
        }
        
        func fetchGeoObjectTypes() async {
            types = await kraevedAPI.getGeoObjectTypes()
        }
        
        private func createGeoObject(thumbnailImage: Image?, photoImages: [UIImage] = []) async throws {
            do {
                let thumbnailUrl = try await upload(thumbnailImage: thumbnailImage)
                let images = try await upload(photoImages: photoImages)
                
                try await kraevedAPI.createGeoObject(
                    geoObject: editedGeoObject,
                    typeId: typeId,
                    images: images,
                    thumbnail: thumbnailUrl
                )
            }
        }
        
        private func updateGeoObject(thumbnailImage: Image?, photoImages: [UIImage] = []) async throws {
            do {
                let thumbnailUrl = try await upload(thumbnailImage: thumbnailImage)
                let images = try await upload(photoImages: photoImages)
                
                try await kraevedAPI.updateGeoObject(
                    geoObject: editedGeoObject,
                    typeId: typeId,
                    images: images,
                    thumbnail: thumbnailUrl
                )
            }
        }
        
        private func upload(thumbnailImage: Image?) async throws -> String {
            guard let image = thumbnailImage?.asUIImage() else { return "" }
            return try await networkManager.upload(images: [image]).first ?? ""
        }
        
        private func upload(photoImages: [UIImage]?) async throws -> [String] {
            guard let photoImages else { return [] }
            return try await self.networkManager.upload(images: photoImages)
        }
        
        //        private func uploadImage(_ imageData: Data, to urlString: String) async {
        //            guard let url = URL(string: urlString) else {
        //                print("Invalid URL")
        //                return
        //            }
        //
        //            var request = URLRequest(url: url)
        //            request.httpMethod = "POST"
        //            //request.setValue("Bearer YOUR_TOKEN", forHTTPHeaderField: "Authorization")  // Если требуется авторизация
        //            //request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        //
        //            let task = URLSession.shared.uploadTask(with: request, from: imageData) { data, response, error in
        //                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        //                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
        //                    return
        //                }
        //
        //                if let mimeType = httpResponse.mimeType, mimeType == "application/json", let data = data {
        //                    // Обработать JSON ответ, если необходимо
        //                }
        //
        //                print("Image uploaded successfully.")
        //            }
        //
        //            task.resume()
        //        }
    }
}
