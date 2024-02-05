//
//  GeoObjectButtonView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 04.02.2024.
//

import SwiftUI

//MARK: - GeoObjectButtonView
struct GeoObjectButtonView: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                Text(title)
                    .font(.system(size: 13))
                    .tint(Color.Kraeved.buttonText)
            }
            .padding(.vertical, 4)
            .frame(width: 78, height: 24)
            .overlay(
                Capsule(style: .circular)
                    .stroke(Color.Kraeved.mainStroke)
            )
            Spacer()
        }
    }
}

#Preview {
    GeoObjectButtonView(title: "Test button", action: {
        print("TAPPED")
    })
}
