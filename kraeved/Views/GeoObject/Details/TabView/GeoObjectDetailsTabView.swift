//
//  GeoObjectDetailsTabView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 08.02.2024.
//

import SwiftUI

//MARK: - GeoObjectDetailsTabView
struct GeoObjectDetailsTabView: View {

    @ObservedObject private var viewModel = ViewModel()
    @State var pageIndex: Int = 0
    
    var geoObject: GeoObject?

    var body: some View {
        VStack {
            HStack {
                ForEach(viewModel.items, id: \.self) { item in
                    GeoObjectDetailsTabButtonView(model: item, currentPageIndex: $pageIndex, action: {
                        //guard $pageIndex != index else { return }
                        pageIndex = item.index
                    })
                }
            }
            TabView(selection: $pageIndex) {
                GeoObjectDetailsDescription(description: geoObject?.description ?? "")
                    .tag(0)
                GeoObjectDetailsGallery(images: geoObject?.images ?? [])
                    .tag(1)
                GeoObjectDetailsComments()
                    .tag(2)
            }
            .tabViewStyle(.page)
            .padding(.top, 16)
        }
    }
}

#Preview {
    GeoObjectDetailsTabView(geoObject: .init(id: 0, name: nil, description: nil, longitude: nil, latitude: nil, type: nil, images: nil, thumbnail: nil))
}
