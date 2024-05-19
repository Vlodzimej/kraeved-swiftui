//
//  SingleImageUploaderView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 16.05.2024.
//

import SwiftUI
import PhotosUI

struct SingleImageUploaderView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ThumbnailImageView(imageState: viewModel.imageState)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.imageSelection, 
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
            }
            .buttonStyle(.borderless)
    }
}
