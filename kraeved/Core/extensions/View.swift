//
//  File.swift
//  kraeved
//
//  Created by Владимир Амелькин on 28.01.2024.
//

import SwiftUI

// A View extension to make the modifier easier to use.
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}
