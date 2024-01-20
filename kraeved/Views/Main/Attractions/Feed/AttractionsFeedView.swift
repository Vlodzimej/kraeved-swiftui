//
//  AttractionsView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.09.2023.
//

import SwiftUI

struct AttractionsFeedView: View {
    @EnvironmentObject private var networkManager: NetworkManager
    @ObservedObject private var viewModel = ViewModel()
    
    @State private var didFail = true
    
    var body: some View {
        VStack(alignment: .leading) {
            MainTitle(title: "Популярное в городе", image: "titleUnderline2")
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            ScrollView {
                ForEach(viewModel.attractions) { geoObject in
                    NavigationLink(destination: AttractionsDetailView(geoObjectId: geoObject.id)) {
                        AttractionsFeedCellView(geoObject: geoObject)
//                            .redacted(reason: viewModel.isLoading ? .placeholder : [])
                            .background(.clear)
                    }
                }
            }
        }
        .background(.clear)
        .task {
            await viewModel.getAttractions()
        }
        .onAppear {
            self.viewModel.setup(networkManager)
        }
    }
}

#Preview {
    return AttractionsFeedView()
        .environmentObject({ () -> NetworkManager in
            let envObj = NetworkManager()
//            envObj.geoObject = mockGeoObject
//            envObj.geoObjects = mockGeoObjects
            envObj.isLoading = false
            return envObj
        }())
}
