//
//  AsyncImage.swift
//  kraeved
//
//  Created by Владимир Амелькин on 04.02.2024.
//

import SwiftUI

struct KraevedAsyncImage: View {
    
    var url: URL?
    
    var body: some View {
        AsyncImage(url: url,
                   content: { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
        },
                   placeholder: {
            EmptyView()
        })
    }
}


