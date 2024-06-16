//
//  MultipleSelectView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 19.05.2024.
//

import SwiftUI
import PhotosUI

struct MultipleImageSelectView: View {
    @ObservedObject var viewModel: ViewModel
    
    private var multipleImageSelectButtonText: String {
        !viewModel.imageSelections.isEmpty ? "multiple-image-select" : ""
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.images, id:\.cgImage){ image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 192, height: 192)
                            .clipped()
                    }
                }
            }
            .padding(.top, 8)
            Spacer()
            PhotosPicker(selection: $viewModel.imageSelections,
                         matching: .images,
                         photoLibrary: .shared()) {
                Label(title: {
                    if viewModel.imageSelections.isEmpty {
                        Text("multiple-image-select-empty")
                    } else {
                        Text("change-selection")
                    }
                }, icon: {
                    Image(systemName: "photo.badge.plus")
                })
                
                .padding(.bottom, 16)
            }
                         .onChange(of: viewModel.imageSelections) { oldValue, newValue in
                             viewModel.images = []
                             for item in newValue {
                                 item.loadTransferable(type: Data.self) { result in
                                     switch result {
                                         case .success(let imageData):
                                             DispatchQueue.main.async {
                                                 if let imageData {
                                                     self.viewModel.hasChanges = true
                                                     self.viewModel.images.append(UIImage(data: imageData)!)
                                                 } else {
                                                     print("No supported content type found.")
                                                 }
                                             }
                                         case .failure(let error):
                                             print(error)
                                     }
                                     
                                 }
                             }
                         }
        }
    }
}
