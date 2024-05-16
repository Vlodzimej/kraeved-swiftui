//
//  GeoObjectDetailsGallery.swift
//  kraeved
//
//  Created by Владимир Амелькин on 05.02.2024.
//

import SwiftUI

//MARK: - GeoObjectDetailsGallery
struct GeoObjectDetailsGallery: View {
    
    //MARK: UIConstants
    struct UIConstants {
        static let spacing: CGFloat = 2
    }
    
    let images: [String]
    
    var items: [GalleryItem] {
        images.enumerated().map({ (index, filename) in
            GalleryItem(id: index, filename: filename)
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
                            AsyncImage(url: URL(string: item.filename)) { phase in
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
    GeoObjectDetailsGallery(images: [])
}
