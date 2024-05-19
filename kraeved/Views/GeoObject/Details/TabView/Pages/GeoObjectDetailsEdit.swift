//
//  GeoObjectDetailsEdit.swift
//  kraeved
//
//  Created by Владимир Амелькин on 19.05.2024.
//

import SwiftUI

struct GeoObjectDetailsEdit: View {
    @State var geoObject: GeoObject?
    let removeAction: (Int) -> Void
    
    var body: some View {
        VStack {
            GeoObjectRemoveActionView(dialogDetail: geoObject, action: removeAction)
        }
    }
}

//#Preview {
//    GeoObjectDetailsEdit()
//}
