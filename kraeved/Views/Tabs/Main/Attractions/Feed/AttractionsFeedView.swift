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
            MainTitle(title: "main.attractionsTitle")
            ScrollView {
                ForEachDividerView(data: viewModel.attractions ?? .init(repeating: .init(), count: 6), id: \.id, color: Color.Kraeved.Gray.light) { attractionBrief in
                    NavigationLink(
                        destination:
                            GeoObjectDetailsView(id: attractionBrief.id, removeAction: { _ in })
                            .padding(.top, 16)
                    ) {
                        AttractionsFeedCellView(attractionBrief: attractionBrief)
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
