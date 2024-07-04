//
//  GenericTextInput.swift
//  kraeved
//
//  Created by Владимир Амелькин on 25.02.2024.
//

import SwiftUI
import Combine

struct KraevedTextInput: View {
    
    @Binding var value: String
    
    let title: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    var limitText: Int = 30
    var lineLimit: Int = 1
    var axis: Axis = .horizontal
    var titleColor: Color = .Kraeved.Gray.darkest
    var backgroundColor: Color = .Kraeved.Gray.lighten
    var innerInsets: EdgeInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey(title))
                .font(.system(size: 12))
                .foregroundStyle(titleColor)
            TextField(LocalizedStringKey(placeholder), text: $value, axis: axis)
                .onReceive(Just(value)) { _ in
                    limitText(limitText)
                }
                .padding(innerInsets)
                .keyboardType(keyboardType)
                .lineLimit(lineLimit)
                .background(backgroundColor)
                .cornerRadius(14)
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
        KraevedTextInput(value: .constant("Sample Text"), title: "Title", placeholder: "Placeholder", keyboardType: .default)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
