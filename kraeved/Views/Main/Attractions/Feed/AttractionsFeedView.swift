//
//  AttractionsView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.09.2023.
//

import SwiftUI

//MARK: - AttractionsFeedView
struct AttractionsFeedView: View {
    
    //MARK: Properties
    @ObservedObject private var viewModel = ViewModel()
    
    //MARK: Body
    var body: some View {
        VStack(alignment: .leading) {
            MainTitle(title: "popular-places", image: "titleUnderline2")
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            ScrollView {
                ForEach(viewModel.attractions ?? .init(repeating: .init(), count: 6)) { attractionBrief in
                    NavigationLink(destination: AttractionsDetailsView(id: attractionBrief.id)) {
                        AttractionsFeedCellView(attractionBrief: attractionBrief)
                            .background(.clear)
                    }
                }
            }
        }
        .background(.clear)
        .task {
            await viewModel.getAttractions()
        }
    }
    
    func reload() async {
        Task {
            await viewModel.getAttractions()
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
