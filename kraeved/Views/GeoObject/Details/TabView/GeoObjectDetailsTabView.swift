//
//  GeoObjectDetailsTabView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 08.02.2024.
//

import SwiftUI
import CachedAsyncImage

//MARK: - GeoObjectDetailsTabView
struct GeoObjectDetailsTabView: View {

    @ObservedObject private var viewModel = ViewModel()
    @State var pageIndex: Int = 0
    
    var geoObject: GeoObject?
    
    var images: [String] {
        geoObject?.images ?? []
    }
    
    var removeAction: (Int) -> Void

    var body: some View {
        VStack {
            TabView(selection: $pageIndex) {
                GeoObjectDetailsDescription(description: geoObject?.description ?? "")
                    .tag(0)
                if !images.isEmpty {
                    GeoObjectDetailsGallery(images: geoObject?.imageUrls ?? [])
                        .tag(1)
                }
                GeoObjectDetailsComments()
                    .tag(2)
                GeoObjectDetailsEdit(geoObject: geoObject, removeAction: removeAction)
                    .tag(3)
            }
            .tabViewStyle(.page)
            .padding(.top, 8)
            HStack {
                ForEach(viewModel.items, id: \.self) { item in
                    if item.type == .gallery && images.isEmpty {
                        EmptyView()
                    } else {
                        GeoObjectDetailsTabButtonView(model: item, currentPageIndex: $pageIndex, action: {
                            pageIndex = item.index
                        })
                    }
                }
            }
        }
    }
}
