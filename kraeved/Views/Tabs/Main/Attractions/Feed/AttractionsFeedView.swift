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
            ZStack {
                Color.white
                ScrollView {
                    ForEach(viewModel.attractions ?? []) { item in
                        NavigationLink(
                            destination:
                                GeoObjectDetailsView(id: item.id, removeAction: { _ in })
                        ) {
                            AttractionsFeedCellView(attractionBrief: item)
                        }
                    }
                }
            }
        }
        .background(.white)
        .task {
            await viewModel.getAttractions()
        }
    }
    
    func reload() async {
        await viewModel.getAttractions()
    }
}



#Preview {
    return AttractionsFeedView()
        .environmentObject({ () -> NetworkManager in
            let envObj = NetworkManager()
            return envObj
        }())
}
