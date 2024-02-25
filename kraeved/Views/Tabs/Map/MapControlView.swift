//
//  MapControlView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 08.02.2024.
//

import SwiftUI

struct MapControlView: View {
    @State private var showingGeoObjectCreation: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    showingGeoObjectCreation = true
                }) {
                    Text("+")
                        .font(.system(size: 16))
                }
                .clipShape(Circle())
                .buttonStyle(.borderedProminent)
                .controlSize(.extraLarge)
                .padding()
                .sheet(isPresented: $showingGeoObjectCreation) {

                }
            }
        }
    }
}

#Preview {
    MapControlView()
}
