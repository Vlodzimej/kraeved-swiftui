//
//  MultipleSelectViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 19.05.2024.
//

import SwiftUI
import PhotosUI
import Alamofire

extension MultipleImageSelectView {
    final class ViewModel: BaseViewModel {
        @Published var images: [UIImage] = []
        @Published var imageSelections: [PhotosPickerItem] = []
        @Published var hasChanges: Bool = false
        
        func fetchImages(by urls: [String]) {
            for url in urls {
                AF.request(url, method: .get).response { [weak self] response in
                    if case .success(let responseData) = response.result, let responseData, let image = UIImage(data: responseData, scale: 1) {
                        self?.images.append(image)
                    }
                }
            }
        }
    }
}
