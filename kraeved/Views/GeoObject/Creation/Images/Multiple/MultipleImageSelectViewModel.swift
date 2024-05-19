//
//  MultipleSelectViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 19.05.2024.
//

import SwiftUI
import PhotosUI

extension MultipleImageSelectView {
    final class ViewModel: BaseViewModel {
        @Published var images: [UIImage] = []
        @Published var imageSelections: [PhotosPickerItem] = []
    }
}
