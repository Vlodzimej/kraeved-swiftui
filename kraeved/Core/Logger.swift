//
//  Logger.swift
//  kraeved
//
//  Created by Владимир Амелькин on 28.01.2024.
//

import Foundation

import Pulse

// MARK: - ApplicationLogLevel
enum ApplicationLogLevel {
    case trace
    case debug
    case info
    case notice
    case warning
    case error
    case critical
    
    var pulseLevel: LoggerStore.Level {
        switch self {
            case .trace:
                return .trace
            case .debug:
                return .debug
            case .info:
                return .info
            case .notice:
                return .notice
            case .warning:
                return .warning
            case .error:
                return .error
            case .critical:
                return .critical
        }
    }
}

//MARK: - ApplicationLoggerProtocol
protocol ApplicationLoggerProtocol {
    func log(label: String, level: ApplicationLogLevel, message: String, userInfo: [String : Any]?)
}

extension ApplicationLoggerProtocol {
    func log(label: String, level: ApplicationLogLevel, message: String, userInfo: [String : Any]?) {
        // По дефолту событие логируется в Pulse
        let metadata = Self.getMetadata(from: userInfo)
        LoggerStore.shared.storeMessage(label: label, level: level.pulseLevel, message: message, metadata: metadata)
    }
    
    private static func getMetadata(from userInfo: [String : Any]?) -> [String: LoggerStore.MetadataValue]? {
        guard let userInfo else { return nil }
        return userInfo.mapValues {
            let value = String(describing: $0) + "\n"
            return .string(value)
        }
    }
}
