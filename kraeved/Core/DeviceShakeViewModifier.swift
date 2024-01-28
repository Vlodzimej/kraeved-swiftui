//
//  DeviceShakeViewModifier.swift
//  kraeved
//
//  Created by Владимир Амелькин on 28.01.2024.
//

import SwiftUI

// A view modifier that detects shaking and calls a function of our choosing.
struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: Notifications.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}
