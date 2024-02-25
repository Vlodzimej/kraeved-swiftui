//
//  MapAnnotationView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 13.02.2024.
//

import SwiftUI

struct MapAnnotationView: View {
    
    let type: GeoObjectType
    
    var body: some View {
        ZStack {
            type.icon
                .resizable()
                .frame(width: 48, height: 48)
        }
    }
}

#Preview {
    MapAnnotationView(type: .unknown)
}
