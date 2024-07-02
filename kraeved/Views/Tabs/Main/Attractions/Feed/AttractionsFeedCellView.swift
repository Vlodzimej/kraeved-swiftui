//
//  AttractionCellView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.09.2023.
//

import SwiftUI
import CachedAsyncImage

//MARK: - AttractionsFeedCellView
struct AttractionsFeedCellView: View {
    
    //MARK: Properties
    let attractionBrief: GeoObjectBrief
    
    //MARK: Body
    var body: some View {
        ZStack(alignment: .leading) {
            Color.white
            HStack(alignment: .top) {
                CachedAsyncImage(url: attractionBrief.thumbnailUrl, urlCache: .imageCache) { state in
                    switch state {
                        case .empty:
                            EmptyThumbnailImageView()
                        case .success(let image):
                            ThumbnailImageView(imageState: .success(image))
                        case .failure:
                            EmptyThumbnailImageView()
                        @unknown default:
                            EmptyView()
                    }
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text(attractionBrief.name ?? "")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.Kraeved.Gray.dark)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 3)
                    Text(attractionBrief.shortDescription ?? "")
                        .font(.system(size: 14))
                        .foregroundColor(Color.Kraeved.Gray.silver)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 16))
        }
        .frame(height: 72)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .background(Color.clear)
        .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
        .redacted(reason: attractionBrief.id == nil ? .placeholder : [])
    }
}
