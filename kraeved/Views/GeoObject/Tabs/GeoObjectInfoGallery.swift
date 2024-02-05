//
//  GeoObjectInfoGallery.swift
//  kraeved
//
//  Created by Владимир Амелькин on 05.02.2024.
//

import SwiftUI

//MARK: - GeoObjectInfoGallery
struct GeoObjectInfoGallery: View {
    
    //MARK: UIConstants
    struct UIConstants {
        static let spacing: CGFloat = 2
    }
    
    let imageUrls: [URL]
    
    var items: [GalleryItem] {
        imageUrls.enumerated().map({ (index, url) in
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
                            AsyncImage(url: item.url) { phase in
                                switch phase {
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
    GeoObjectInfoGallery(imageUrls: [])
}
