//
//  MainTitle.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.09.2023.
//

import SwiftUI

struct MainTitle: View {
    
    let title: LocalizedStringKey
    let imageName: String?
    
    init(title: LocalizedStringKey, imageName: String? = nil) {
        self.title = title
        self.imageName = imageName
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .offset(CGSize(width: 16, height: 8))
                .foregroundColor(Color.Pallete.viridian)
            if let imageName {
                Image(imageName)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            Spacer()
                .frame(maxWidth: .infinity)
        }
        .padding(.bottom, 8)
    }
}

#Preview {
    MainTitle(title: "common.events", imageName: "titleUnderline")
}
