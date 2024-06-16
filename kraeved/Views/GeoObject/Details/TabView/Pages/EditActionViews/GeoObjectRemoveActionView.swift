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
        Button("geoObject.remove") {
            isConfirming = true
        }
        .confirmationDialog(LocalizedStringKey("geoObject.deleteConfirm \(dialogDetail?.name ?? "")"),
                            isPresented: $isConfirming,
                            titleVisibility: .visible,
                            presenting: dialogDetail
        ) { geoObject in
            Button("common.remove", role: .destructive) {
                guard let id = geoObject.id else { return }
                action(id)
            }
            Button("common.cancel", role: .cancel, action: {})
        }
    }
}
