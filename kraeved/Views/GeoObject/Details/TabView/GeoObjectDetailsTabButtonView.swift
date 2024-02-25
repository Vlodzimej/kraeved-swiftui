//
//  GeoObjectDetailsTabButtonView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 04.02.2024.
//

import SwiftUI

//MARK: - GeoObjectDetailsTabButtonView
struct GeoObjectDetailsTabButtonView: View {
    
    let model: KraevedTabItem
    
    @Binding var currentPageIndex: Int
    
    let action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                Text(model.type.title)
                    .font(.system(size: 13))
                    .tint(currentPageIndex == model.index ? Color.Kraeved.highlightedText : Color.Kraeved.buttonText)
            }
            .padding(.vertical, 4)
            .frame(width: 78, height: 24)
            .overlay(
                Capsule()
                    .stroke()
                    .foregroundColor(.Kraeved.mainStroke)
                )
            .background(currentPageIndex == model.index ? Color.Kraeved.cellBackground : Color.Kraeved.secondBackground)
            .clipShape(
                Capsule(style: .circular)
            )
            Spacer()
        }
    }
}

//#Preview {
//    @State var pageIndex = 0
//    return GeoObjectDetailsTabButtonView(model: .init(id: 0, title: "Test"), currentPageIndex: $pageIndex, action: {
//        print("TAPPED")
//    })
//}
