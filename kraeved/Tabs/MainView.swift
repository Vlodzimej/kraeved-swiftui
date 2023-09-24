//
//  MainView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var networkManager = NetworkManager.shared
    
    var body: some View {
        ScrollView {
            Text("Main")
        }
        .onAppear {
            networkManager.getGeoObject()
        }
    }
    
}

#Preview {
    MainView()
}
