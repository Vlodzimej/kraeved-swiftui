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
            Circle()
				.stroke(Color.Pallete.viridian, lineWidth: 1)
				.fill(Color.Pallete.cambridgeBlue.opacity(0.8))
                .frame(width: 48, height: 48)
				.shadow(radius: 10)
            
            type.icon
                .resizable()
                .frame(width: 24, height: 24)
                .opacity(0.8)
				.foregroundColor(Color.Pallete.azure)
        }
		.foregroundStyle(.opacity(0.8))
    }
}

#Preview {
    MapAnnotationView(type: .unknown)
}
