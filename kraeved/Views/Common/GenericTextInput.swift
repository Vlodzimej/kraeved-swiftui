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
    var symbolsLimit: Int = 30
    var axis: Axis = .horizontal
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 12))
            TextField(placeholder, text: $value, axis: axis)
                .onReceive(Just(value)) {
                    _ in limitText(symbolsLimit)
                }
                .keyboardType(keyboardType)
        }
    }
    
    //Function to keep text length in limits
    func limitText(_ upper: Int) {
        if value.count > upper {
            value = String(value.prefix(upper))
        }
    }
}
