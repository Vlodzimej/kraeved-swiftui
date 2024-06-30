//
//  GenericTextInput.swift
//  kraeved
//
//  Created by Владимир Амелькин on 25.02.2024.
//

import SwiftUI
import Combine

struct GenericTextInput: View {
    
    @Binding var value: String
    
    let title: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    var limitText: Int = 30
    var lineLimit: Int = 1
    var axis: Axis = .horizontal
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey(title))
                .font(.system(size: 12))
                .foregroundStyle(Color.Kraeved.mainStroke)
            TextField(LocalizedStringKey(placeholder), text: $value, axis: axis)
                .onReceive(Just(value)) { _ in
                    limitText(limitText)
                }
                .keyboardType(keyboardType)
                .lineLimit(lineLimit)
        }
    }
    
    // Function to keep text length within limits
    func limitText(_ upper: Int) {
        if value.count > upper {
            value = String(value.prefix(upper))
        }
    }
}

struct GenericTextInput_Previews: PreviewProvider {
    static var previews: some View {
        GenericTextInput(value: .constant("Sample Text"), title: "Title", placeholder: "Placeholder", keyboardType: .default)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
