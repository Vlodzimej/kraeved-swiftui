//
//  MapView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.07.2024.
//

import SwiftUI

struct MapView: View {
    
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            YandexMapView()
                .edgesIgnoringSafeArea(.all)
                .environmentObject(locationManager)
        }
        .onAppear{
            locationManager.currentUserLocation()
        }
    }
}

#Preview {
    MapView()
}
