//
//  Configuration.swift
//  kraeved
//
//  Created by Владимир Амелькин on 17.01.2024.
//

import Foundation

enum Configuration: String {

    // MARK: - Configurations
    case localDevelopment
    case development
    case testing
    case production

    // MARK: - Current Configuration
    static let current: Configuration = {
        print(Bundle.main.infoDictionary?["Icon file"])
        guard let rawValue = Bundle.main.infoDictionary?["Configuration"] as? String else {
            fatalError("No Configuration Found")
        }

        guard let configuration = Configuration(rawValue: rawValue.lowercased()) else {
            fatalError("Invalid Configuration")
        }
        return configuration
    }()

    // MARK: - Base URL
    static var baseURL: String {
        switch current {
            case .localDevelopment:
                return "https://localhost"
            case .development:
                return "https://192.168.1.4"
            case .testing:
                return ""
            case .production:
                return ""
        }
    }

}
