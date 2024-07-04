//
//  EmptyPlacheholder.swift
//  kraeved
//
//  Created by Владимир Амелькин on 03.07.2024.
//

import SwiftUI

//MARK: - EmptyPlacheholderView
struct EmptyPlacheholderView: View {
    
    //MARK: Properties
    var image: Image
    var title: String
    
    //MARK: Body
    var body: some View {
        VStack(spacing: 16) {
            image
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundStyle(Color.Pallete.viridian)
            Text(LocalizedStringKey(title))
                .font(.system(size: 17))
                .foregroundStyle(Color.Pallete.viridian)
        }
    }
}

#Preview {
    EmptyPlacheholderView(image: Image(systemName: "nosign"), title: "common.notFound")
}
