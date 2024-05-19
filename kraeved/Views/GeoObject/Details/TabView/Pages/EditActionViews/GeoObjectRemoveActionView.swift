//
//  GeoObjectRemoveActionView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 19.05.2024.
//

import SwiftUI

struct GeoObjectRemoveActionView: View {
    @State private var isConfirming = false
    @State var dialogDetail: GeoObject?
    let action: (Int) -> Void
    
    var body: some View {
        Button("geo-object-remove") {
            isConfirming = true
        }
        .confirmationDialog("Вы действительно хотите удалить объект «\(dialogDetail?.name ?? "")»",
            isPresented: $isConfirming,
            presenting: dialogDetail
        ) { geoObject in
            Button("remove", role: .destructive) {
                //guard let id = geoObject.id else { return }
                action(geoObject.id)
            }
            Button("cancel", role: .cancel, action: {})
        }
    }
}
