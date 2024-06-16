//
//  SingleImageUploaderViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 16.05.2024.
//

import SwiftUI
import PhotosUI
import Alamofire

extension SingleImageUploaderView {
    
    final class ViewModel: BaseViewModel {

        private(set) var hasChanges: Bool = false
        
        @Published var imageState: UploadImageState = .empty
        @Published var image: UIImage?
        
        @Published var imageSelection: PhotosPickerItem? {
            didSet {
                if let imageSelection {
                    let progress = loadTransferable(from: imageSelection)
                    imageState = .loading(progress)
                    hasChanges = true
                } else {
                    imageState = .empty
                }
            }
        }
        
        var uploadedImage: Image? {
            guard hasChanges, case .success(let image) = imageState else { return nil }
            return image
        }
        
        private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
            return imageSelection.loadTransferable(type: Data.self) { result in
                DispatchQueue.main.async {
                    guard imageSelection == self.imageSelection else { return }
                    switch result {
                        case let .success(data?):
                            guard let uiImage = UIImage(data: data) else {
                                self.imageState = .empty
                                return
                            }
                            self.image = uiImage
                            self.imageState = .success(Image(uiImage: uiImage))
                        case .success(.none):
                            self.imageState = .empty
                        case let .failure(error):
                            self.imageState = .failure(error)
                    }
                }
            }
        }
        
        func fetchImage(by url: String) {
            AF.request(url, method: .get).response { [weak self] response in
                switch response.result {
                    case .success(let responseData):
                        if let responseData, let image = UIImage(data: responseData, scale: 1) {
                            self?.imageState = .success(Image(uiImage: image))
                        }
                    case .failure:
                        self?.imageState = .empty
                }
            }
        }
    }
}
