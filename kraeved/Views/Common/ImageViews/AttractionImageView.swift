//
//  AttractionImageView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 04.07.2024.
//

import SwiftUI

struct AttractionImageView: View {
    let imageState: UploadImageState
    
    var body: some View {
        switch imageState {
            case .empty:
                ProgressView()
            case .loading:
                ProgressView()
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
        }
    }
}
