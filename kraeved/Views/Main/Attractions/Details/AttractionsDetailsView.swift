//
//  AttractionsDetailsView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 02.10.2023.
//

import SwiftUI

//MARK: - AttractionsDetailsView
struct AttractionsDetailsView: View {
    
    //MARK: Properties
    let id: Int?
    @ObservedObject private var viewModel = ViewModel()

    //MARK: Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(viewModel.attraction?.name ?? "")
                    .font(.title)
                Spacer()
                Text(viewModel.attraction?.description ?? "")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .task {
                guard let id else { return }
                await viewModel.getAttraction(id: id)
            }
        }
    }
}

//#Preview {
//    AttractionsDetailsView(geoObjectId: 1)
//        .environmentObject({ () -> NetworkManager in
//            let envObj = NetworkManager()
//            envObj.geoObject = mockGeoObject
//            return envObj
//        }())
//}
