//
//  GeoObjectDetailsGallery.swift
//  kraeved
//
//  Created by Владимир Амелькин on 05.02.2024.
//

import SwiftUI
import CachedAsyncImage

//MARK: - GeoObjectDetailsGallery
struct GeoObjectDetailsGallery: View {
    
    //MARK: UIConstants
    struct UIConstants {
        static let spacing: CGFloat = 2
    }
    
    let images: [URL]
    
    var items: [GalleryItem] {
        images.enumerated().compactMap({ (index, url) in
            GalleryItem(id: index, url: url)
        })
    }
    
    let columns = [
        GridItem(.flexible(maximum: .infinity), spacing: UIConstants.spacing),
        GridItem(.flexible(maximum: .infinity), spacing: UIConstants.spacing),
        GridItem(.flexible(maximum: .infinity), spacing: UIConstants.spacing)
    ]
    
    var body: some View {
        //GeometryReader { geometry in
        ScrollView {
            LazyVGrid(columns: columns, spacing: UIConstants.spacing) {
                ForEach(items, id: \.self.id) { item in
                    Color.clear
                        .overlay {
                            CachedAsyncImage(url: item.url, urlCache: .imageCache) { state in
                                switch state {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    default:
                                        Image(systemName: "photo")
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit) 
                        .clipped()
                }
            }
        }
    }
}

#Preview {
    GeoObjectDetailsGallery(images: [])
}
