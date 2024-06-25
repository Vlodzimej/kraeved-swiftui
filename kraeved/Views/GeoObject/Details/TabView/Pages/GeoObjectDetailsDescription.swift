//
//  GeoObjectDetailsDescription.swift
//  kraeved
//
//  Created by Владимир Амелькин on 05.02.2024.
//

import SwiftUI

struct GeoObjectDetailsDescription: View {
    
    let description: String
    
    var body: some View {
        ScrollView {
            Text(description)
                .padding(.horizontal, 16)
                .font(.system(size: 13))
                .foregroundStyle(Color.Kraeved.darkGrey)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    GeoObjectDetailsDescription(description: "Test")
}
