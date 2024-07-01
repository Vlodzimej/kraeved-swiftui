//
//  AuthManager.swift
//  kraeved
//
//  Created by Владимир Амелькин on 29.06.2024.
//

import Foundation
import Security

//MARK: - SecurityManagerProtocol
protocol SecurityManagerProtocol {
    func savePassword(service: String, account: String, password: String) -> Bool
    func getPassword(service: String, account: String) -> String? 
    func deletePassword(service: String, account: String) -> Bool
    func saveToken(service: String, account: String, token: String) -> Bool
    func getToken(service: String, account: String) -> String?
    func deleteToken(service: String, account: String) -> Bool
}

//MARK: - SecurityManager
final class SecurityManager: SecurityManagerProtocol {
    
    static let shared = SecurityManager()
    
    // Function to save password to Keychain
    func savePassword(service: String, account: String, password: String) -> Bool {
        let data = password.data(using: .utf8)!
        
        // Create query for adding password
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        // Delete any existing items
        SecItemDelete(query as CFDictionary)
        
        // Add new item to keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    // Function to retrieve password from Keychain
    func getPassword(service: String, account: String) -> String? {
        // Create query for searching password
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            if let data = dataTypeRef as? Data {
                return String(data: data, encoding: .utf8)
            }
        }
        
        return nil
    }
    
    @discardableResult
    func deletePassword(service: String, account: String) -> Bool {
        // Create query for deleting password
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        return status == errSecSuccess
    }
    
    // Function to save JWT token to Keychain
    func saveToken(service: String, account: String, token: String) -> Bool {
        let data = token.data(using: .utf8)!
        
        // Create query for adding token
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        // Delete any existing items
        SecItemDelete(query as CFDictionary)
        
        // Add new item to keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    func getToken(service: String, account: String) -> String? {
        // Create query for searching token
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            if let data = dataTypeRef as? Data {
                return String(data: data, encoding: .utf8)
            }
        }
        
        return nil
    }
    
    @discardableResult
    func deleteToken(service: String, account: String) -> Bool {
        // Create query for deleting token
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        return status == errSecSuccess
    }
}
