//
//  UIWindow.swift
//  kraeved
//
//  Created by Владимир Амелькин on 28.01.2024.
//

import UIKit

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: Notifications.deviceDidShakeNotification, object: nil)
        }
    }
}
