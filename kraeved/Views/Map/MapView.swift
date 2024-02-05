//
//  MapView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI
import MapKit
import CoreLocation

//MARK: - MapView
struct MapView: View {
    
    @ObservedObject private var viewModel = ViewModel()
    
    @State private var region = MKCoordinateRegion(center: Constants.initialLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @State private var isShowingDetailInfo: Bool = false
    
    var body: some View {
        Map {
            ForEach(viewModel.geoObjects ?? [], id: \.id) { geoObject in
                Annotation(geoObject.name ?? "", coordinate: .init(latitude: geoObject.latitude ?? 0, longitude: geoObject.longitude ?? 0)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.yellow)
                        Text(geoObject.type?.name ?? "")
                            .padding(5)
                    }
                    .onTapGesture {
                        isShowingDetailInfo = true
                    }
                    .sheet(isPresented: $isShowingDetailInfo) {
                        GeoObjectView(id: geoObject.id)
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.automatic)
                    }
                }
            }
        }
        .mapStyle(.standard(pointsOfInterest: .excludingAll))
        .task {
            await viewModel.getGeoObjects()
        }
    }
}

#Preview {
    MapView()
}


//Map(coordinateRegion: $region, annotationItems:
//(viewModel.geoObjects ?? []).map({ geoObject in
//Annotation(coordinate: .init(latitude: geoObject.latitude,
//                             longitude: geoObject.longitude)) {
//    Text("TEST")
//}
