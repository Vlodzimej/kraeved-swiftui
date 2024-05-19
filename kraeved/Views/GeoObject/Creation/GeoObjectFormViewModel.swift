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
        
        var mode: GeoObjectFormMode = .creation
        
        @Published var name: String = ""
        @Published var typeId: Int = 0
        @Published var description: String = ""
        @Published var regionId: Int = 40
        @Published var images: [String] = []
        @Published var thumbnail: String = ""
        @Published var types: [GenericType]?
        
        var latitude: String = ""
        var longitude: String = ""
        
        func submit(latitude: String, longitude: String, thumbnail: UploadImageState, images: [UIImage]) {
            self.latitude = latitude
            self.longitude = longitude
            
            var thumbnailImage: Image?
            
            if case let .success(image) = thumbnail {
                thumbnailImage = image
            }
            
            switch mode {
                case .creation:
                    createGeoObject(thumbnailImage: thumbnailImage, photoImages: images)
                case .edit: break
                    //updateGeoObject()
            }
        }
        
        func fetchGeoObjectTypes() async {
            types = await kraevedAPI.getGeoObjectTypes()
        }
        
        private func createGeoObject(thumbnailImage: Image?, photoImages: [UIImage] = []) {
            Task {
                await MainActor.run {
                    isLoading = true
                }
                do {
                    var thumbnailUrl: String = ""
                    if let image = thumbnailImage?.asUIImage(), let thumbnailFilename = try await networkManager.upload(images: [image]).first {
                        thumbnailUrl = thumbnailFilename
                    }
                    
                    let images = photoImages.isEmpty ? [] :  try await networkManager.upload(images: photoImages)
                    
                    try await kraevedAPI.createGeoObject(
                        name: name,
                        typeId: typeId,
                        description: description,
                        latitude: Double(latitude) ?? 0,
                        longitude: Double(longitude) ?? 0,
                        regionId: regionId,
                        images: images,
                        thumbnail: thumbnailUrl
                    )
                    
                    await MainActor.run {
                        isLoading = false
                    }
                }
            }
        }
    }
    
    private func updateGeoObject() {
        
    }
    
    private func uploadImage(_ imageData: Data, to urlString: String) async {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //request.setValue("Bearer YOUR_TOKEN", forHTTPHeaderField: "Authorization")  // Если требуется авторизация
        //request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: imageData) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let mimeType = httpResponse.mimeType, mimeType == "application/json", let data = data {
                // Обработать JSON ответ, если необходимо
            }
            
            print("Image uploaded successfully.")
        }
        
        task.resume()
    }
}

