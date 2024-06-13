//
//  MapView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI
import MapKit
import CoreLocation

enum MapMode {
    case search, create, remove
}


//MARK: - MapView
struct MapView: View {

    @ObservedObject private var viewModel = ViewModel()
    
    @State private var region = MKCoordinateRegion(center: Constants.initialLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    @State var mkMapView: MKMapView = .init()
    
    @State private var selectedGeoObjectId: Int? = nil
    @State private var searchText: String = ""
    @State private var isShowFilter: Bool = false
    @State private var isShowSelection: Bool = false
    @State private var isShowCreation: Bool = false
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    
    func handleLongPressGesture() -> some Gesture {
        LongPressGesture(minimumDuration: 0.25)
            .onEnded { value in
                // let convertedCoordinate = mkMapView.convert(value.location, toCoordinateFrom: mkMapView)
                
            }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    MapReader { reader in
                        Map(initialPosition: .region(region)) {
                            ForEach(viewModel.geoObjects ?? [], id: \.id) { geoObject in
                                Annotation(
                                    geoObject.name ?? "",
                                    coordinate: .init(
                                        latitude: geoObject.latitude ?? 0, 
                                        longitude: geoObject.longitude ?? 0
                                    )) {
                                    MapAnnotationView(type: geoObject.type ?? .unknown)
                                        .onTapGesture {
                                            selectedGeoObjectId = geoObject.id
                                        }
                                }
                            }
                            if let selectedCoordinate {
                                Marker("new-geo-object-marker", coordinate: selectedCoordinate)
                            }
                        }
                        .mapStyle(.standard(pointsOfInterest: .excludingAll))
                        .task {
                            await viewModel.getGeoObjects()
                        }
                        .sheet(item: $selectedGeoObjectId, onDismiss: {
                            selectedGeoObjectId = nil
                        }) { id in
                            MapSheetWrapperView {
                                GeoObjectDetailsView(id: id, removeAction: { id in
                                    Task {
                                        try await viewModel.removeGeoObject(by: id)
                                        await MainActor.run {
                                            selectedGeoObjectId = nil
                                        }
                                    }
                                })
                            }
                            .background(Color.Kraeved.secondBackground)
                        }
                        .sheet(isPresented: $isShowFilter) {
                            Text("filter")
                        }
                        .fullScreenCover(isPresented: $isShowCreation, onDismiss: {
                            removeSelectedGeoObject()
                            Task {
                                await viewModel.getGeoObjects()
                            }
                        }) {
                            GeoObjectFormView(
                                initialGeoObject: GeoObject(longitude: longitude, latitude: latitude),
                                isShowForm: $isShowCreation,
                                mode: .creation
                            )
                        }
                        .onTapGesture { tapPosition in
                            if isShowSelection {
                                selectedCoordinate = reader.convert(tapPosition, from: .local)
                                if let latitude = selectedCoordinate?.latitude.description {
                                    self.latitude = latitude
                                }
                                if let longitude = selectedCoordinate?.longitude.description {
                                    self.longitude = longitude
                                }
                            }
                        }
                    }
                    if isShowSelection {
                        MapViewSelection(latitude: $latitude, longitude: $longitude, selectedGeoObjectId: $selectedGeoObjectId, isShowCreation: $isShowCreation, onDismiss: {
                            removeSelectedGeoObject()
                            withAnimation {
                                isShowSelection.toggle()
                            }
                        })
                        .transition(.move(edge: .bottom))
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    TextField("search", text: $searchText)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu(content: {
                        
                        Button {
                            isShowFilter = true
                        } label: {
                            Label("show-filter", systemImage: "line.3.horizontal.decrease.circle")
                        }
                        
                        Button {
                            withAnimation {
                                isShowSelection = true
                            }
                        } label: {
                            Label("geo-object-create", systemImage: "plus.circle")
                        }
                    }) {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .toolbar(!isShowSelection ? .visible : .hidden)
        }
    }
    
    private func removeSelectedGeoObject() {
        selectedCoordinate = nil
        latitude = ""
        longitude = ""
    }
    
    private func update(latitude: String?, longitude: String?) {
        guard let newLatitude = (latitude as? NSString)?.doubleValue,
              let newLongitude = (longitude as? NSString)?.doubleValue,
              newLatitude > 0 && newLongitude > 0 else { return }
        self.selectedCoordinate = CLLocationCoordinate2D(latitude: newLatitude, longitude: newLongitude)
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
