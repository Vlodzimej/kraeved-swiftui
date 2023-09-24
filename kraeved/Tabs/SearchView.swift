//
//  SearchView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://files.betamax.raywenderlich.com/attachments/collections/194/e12e2e16-8e69-432c-9956-b0e40eb76660.png")) { image in
          image.resizable()
        } placeholder: {
          Color.red
        }
        .frame(width: 128, height: 128)
    }
}

#Preview {
    SearchView()
}
