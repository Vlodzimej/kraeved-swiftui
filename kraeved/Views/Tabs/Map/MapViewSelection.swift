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
            GenericTextInput(
                value: $latitude,
                title: String(localized: "latitude"),
                placeholder: String(localized: "latitude"),
                keyboardType: .decimalPad
            )
            Divider()
            GenericTextInput(
                value: $longitude,
                title: String(localized: "longitude"),
                placeholder: String(localized: "longitude"),
                keyboardType: .decimalPad
            )
            
            Spacer()
            Button {
                isShowCreation = true
            } label: {
                Text("geo-object-create")
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
