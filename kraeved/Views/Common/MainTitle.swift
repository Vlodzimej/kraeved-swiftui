//
//  MainTitle.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.09.2023.
//

import SwiftUI

struct MainTitle: View {
    
    let title: LocalizedStringKey
    let image: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .offset(CGSize(width: 16, height: 8))
                .foregroundColor(Color.Kraeved.titleFontMain)
            Image(image)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            Spacer()
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    MainTitle(title: "События", image: "titleUnderline")
}
