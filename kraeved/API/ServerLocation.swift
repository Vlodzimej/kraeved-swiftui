//
//  ServerLocation.swift
//  kraeved
//
//  Created by Владимир Амелькин on 17.01.2024.
//

import Foundation

public enum ServerLocation {
    
    case localDevelopment
    case development
    case testing
    case production
    
    var type: String {
        switch self {
            case .localDevelopment:
                return "Local Development"
            case .development:
                return "Development"
            case .testing:
                return "Testing"
            case .production:
                return "Production"
        }
    }
    
    var host: String {
        switch self {
            case .localDevelopment:
                return "localhost:5213/api"
            case .development:
                return "192.168.1.4"
            case .testing:
                return ""
            case .production:
                return ""
        }
    }
    
    var baseUrl: String {
        switch self {
            case .localDevelopment:
                return "http://\(host)"
            case .development, .testing, .production:
                return "https://\(host)"
        }
    }
}
