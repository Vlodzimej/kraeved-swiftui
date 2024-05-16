//
//  EmptyThumbnailImageView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 16.05.2024.
//

import SwiftUI

struct EmptyThumbnailImageView: View {
    var body: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .foregroundColor(Color.gray)
    }
}

#Preview {
    EmptyThumbnailImageView()
}
