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
    @State private var isLoggerPresented = false
    
    init() {
        URLSessionProxyDelegate.enableAutomaticRegistration()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onShake {
                    LoggerStore.shared.storeMessage(
                        label: "auth",
                        level: .debug,
                        message: "Will login user",
                        metadata: ["userId": .string("uid-1")]
                    )
                    isLoggerPresented = true
                }.sheet(isPresented: $isLoggerPresented) {
                    LoggerView()
                }
        }
    }
}
