//
//  ImageUploadView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 16.05.2024.
//

import SwiftUI

struct ImageUploadView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        EditableThumbnailImageView(viewModel: viewModel)
    }
}
