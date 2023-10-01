//
//  MapView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI
import MapKit

struct MapView: View {

    @State private var region = MKCoordinateRegion(center: Constants.initialLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

    var body: some View {
        Map(coordinateRegion: $region)
            .onAppear {
                
            }
    }
}

#Preview {
    MapView()
}
