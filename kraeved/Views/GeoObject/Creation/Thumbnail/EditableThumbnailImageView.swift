//
//  ThumbnailField.swift
//  kraeved
//
//  Created by Владимир Амелькин on 16.05.2024.
//

import SwiftUI
import PhotosUI

struct EditableThumbnailImageView: View {
    @ObservedObject var viewModel: ImageUploadView.ViewModel
    
    var body: some View {
        ThumbnailImageView(imageState: viewModel.imageState)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.imageSelection, matching: .images, photoLibrary: .shared()) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
            }
            .buttonStyle(.borderless)
    }
}
