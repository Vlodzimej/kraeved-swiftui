//
//  MapSheetWrapperView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 08.02.2024.
//

import SwiftUI

struct MapSheetWrapperView<Content: View>: View {

    let content: Content
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
        
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.Kraeved.mainStroke)
                .frame(width: 30, height: 4)
                .padding(10)
            content
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.automatic)
                .padding(.top, 22)
                .presentationDragIndicator(.hidden)
            Spacer()
        }
    }
}

//#Preview {
//    MapSheetWrapperView(childView: GeoObjectDetailsView(id: 0))
//}
