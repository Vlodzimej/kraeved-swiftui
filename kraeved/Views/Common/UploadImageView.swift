//
//  ProfileImage.swift
//  kraeved
//
//  Created by Владимир Амелькин on 16.05.2024.
//

import SwiftUI

struct UploadImageView: View {
    let imageState: UploadImageState
    
    var body: some View {
        switch imageState {
            case .empty:
                Image(systemName: "photo.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            case .loading:
                ProgressView()
            case let .success(image):
                image.resizable().scaledToFit()
            case .failure:
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
        }
    }
}
