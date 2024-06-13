//
//  GeoObjectDetailsEdit.swift
//  kraeved
//
//  Created by Владимир Амелькин on 19.05.2024.
//

import SwiftUI

struct GeoObjectDetailsEdit: View {
    @State var geoObject: GeoObject?
    
    @State var isShowEditForm: Bool = false
    let removeAction: (Int) -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            GeoObjectRemoveActionView(dialogDetail: geoObject, action: removeAction)
            Button {
                isShowEditForm = true
            } label: {
                Text("geoObject.edit")
            }
        }
        .fullScreenCover(isPresented: $isShowEditForm, onDismiss: {

        }) {
            GeoObjectFormView(
                initialGeoObject: geoObject,
                isShowForm: $isShowEditForm,
                mode: .edit
            )
        }
    }
}

//#Preview {
//    GeoObjectDetailsEdit()
//}
