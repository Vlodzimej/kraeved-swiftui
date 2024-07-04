//
//  CircularProfileImage.swift
//  kraeved
//
//  Created by Владимир Амелькин on 16.05.2024.
//

import SwiftUI

struct ThumbnailImageView: View {
    let imageState: UploadImageState
    
    var body: some View {
        UploadImageView(imageState: imageState)
            .scaledToFill()
            .frame(width: 72, height: 72)
            .clipShape(.rect(cornerRadius: 14))
            .background {
                Rectangle()
                    .fill(
                        LinearGradient(colors: [.yellow, .orange],
                                       startPoint: .top,
                                       endPoint: .bottom))
                    .clipShape(.rect(cornerRadius: 14))
            }
            .clipped()
    }
}
