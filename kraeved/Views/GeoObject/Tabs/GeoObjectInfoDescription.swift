//
//  GeoObjectInfoDescription.swift
//  kraeved
//
//  Created by Владимир Амелькин on 05.02.2024.
//

import SwiftUI

struct GeoObjectInfoDescription: View {
    
    let description: String
    
    var body: some View {
        ScrollView {
            Text(description)
                .font(.system(size: 13))
        }
    }
}

#Preview {
    GeoObjectInfoDescription(description: "Test")
}
