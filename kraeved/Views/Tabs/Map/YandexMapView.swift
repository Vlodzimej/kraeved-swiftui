//
//  YandexMapView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.07.2024.
//

import SwiftUI
import YandexMapsMobile
import Combine

//MA
struct YandexMapView: UIViewRepresentable {
    @EnvironmentObject var locationManager: LocationManager
    
    func makeUIView(context: Context) -> YMKMapView {
        return locationManager.mapView
    }
    
    func updateUIView(_ mapView: YMKMapView, context: Context) {}
}
