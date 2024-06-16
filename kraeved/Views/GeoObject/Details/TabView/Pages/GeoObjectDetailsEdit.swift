//
//  GeoObjectDetailsEdit.swift
//  kraeved
//
//  Created by Владимир Амелькин on 19.05.2024.
//

import SwiftUI

struct GeoObjectDetailsEdit: View {
    @State var geoObject: GeoObject?
    
    @State var isEditFormPresented: Bool = false
    let removeAction: (Int) -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            GeoObjectRemoveActionView(dialogDetail: geoObject, action: removeAction)
            Button {
                isEditFormPresented = true
            } label: {
                Text("geoObject.edit")
            }
        }
        .fullScreenCover(isPresented: $isEditFormPresented, onDismiss: {
        }) {
            GeoObjectFormView(
                initialGeoObject: geoObject,
                mode: .edit
            )
        }
    }
}

//#Preview {
//    GeoObjectDetailsEdit()
//}
