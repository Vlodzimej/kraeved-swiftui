//
//  KraevedApp.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI
import Pulse

@main
struct KraevedApp: App {
    init() {
        URLSessionProxyDelegate.enableAutomaticRegistration()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
