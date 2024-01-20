////
////  Settings.swift
////  kraeved
////
////  Created by Владимир Амелькин on 17.01.2024.
////

import Foundation

final class Settings {
    
    enum BundleIdentifierType: String {
        case localDev = "vlodzimej.kraeved.localDev"
        case dev      = "vlodzimej.kraeved.dev"
        case test     = "vlodzimej.kraeved.test"
        case prod     = "vlodzimej.kraeved"
    }
    
    static let instance = Settings()
    
    private(set) lazy var currentEnvironment: BundleIdentifierType = {
        if let identifier = Bundle.main.bundleIdentifier, let identifierType = BundleIdentifierType(rawValue: identifier) {
            return identifierType
        } else {
            fatalError("unknown bundle identifier")
            return BundleIdentifierType.prod
        }
    }()
    
    var baseUrl: String {
        let serverLocation: ServerLocation
        switch Settings.instance.currentEnvironment {
            case .localDev:
                serverLocation = .localDevelopment
            case .dev:
                serverLocation = .development
            case .test:
                serverLocation = .testing
            case .prod:
                serverLocation = .production
        }
        return serverLocation.baseUrl
    }
}
