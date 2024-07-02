//
//  MapViewSelection.swift
//  kraeved
//
//  Created by Владимир Амелькин on 08.02.2024.
//

import SwiftUI
import Combine

struct FormItemModel {
    var value: Binding<String>
    let title: String
    let placeholder: String
    let keyboardType: UIKeyboardType
}

//MARK: - MapViewSelection
struct MapViewSelection: View {
    @Binding var latitude: String
    @Binding var longitude: String
    @Binding var selectedGeoObjectId: Int?
    @Binding var isShowCreation: Bool
    
    @State private var isLocationSelected: Bool = false
    
    var onDismiss: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        onDismiss?()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
                newGeoObjectCoordinateView
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(Color.white)
        }
    }
    
    private var newGeoObjectCoordinateView: some View {
        VStack {
            KraevedTextInput(
                value: $latitude,
                title: String(localized: "common.latitude"),
                placeholder: String(localized: "common.latitude"),
                keyboardType: .decimalPad
            )
            Divider()
            KraevedTextInput(
                value: $longitude,
                title: String(localized: "common.longitude"),
                placeholder: String(localized: "common.longitude"),
                keyboardType: .decimalPad
            )
            
            Spacer()
            Button {
                isShowCreation = true
            } label: {
                Text("geoObject.create")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(latitude.isEmpty && longitude.isEmpty)
        }
    }
}

//#Preview {
//    @State var longitude: String = ""
//    @State var latitude: String = ""
//    @State var isShowCreation: Bool = false
//
//    return MapViewSelection(latitude: $latitude, longitude: $longitude, selectedGeoObjectIdisShowCreation: $isShowCreation)
//}
