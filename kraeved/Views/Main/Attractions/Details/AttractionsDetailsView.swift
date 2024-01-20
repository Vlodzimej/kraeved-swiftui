//
//  AttractionsDetailView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 02.10.2023.
//

import SwiftUI

struct AttractionsDetailView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    let geoObjectId: Int
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(networkManager.geoObject?.name ?? "")
                    .font(.title)
                Spacer()
                Text(networkManager.geoObject?.description ?? "")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .task {
                viewModel.
            }
        }
    }
    
}

#Preview {
    AttractionsDetailView(geoObjectId: 1)
        .environmentObject({ () -> NetworkManager in
            let envObj = NetworkManager()
            envObj.geoObject = mockGeoObject
            return envObj
        }())
}
