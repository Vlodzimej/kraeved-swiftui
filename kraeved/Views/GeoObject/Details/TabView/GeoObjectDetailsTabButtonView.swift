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
                    .font(.system(size: 16))
                    .tint(currentPageIndex == model.index ? Color.Kraeved.Gray.dark : Color.Kraeved.Gray.silver)
            }
            .padding(.vertical, 4)
            .frame(width: 78, height: 24)
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
