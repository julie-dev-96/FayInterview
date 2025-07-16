//
//  KeychainService.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import Foundation
import Security

/// @mockable
protocol KeychainServicing {
    func setString(_ string: String?, forKey key: KeychainKey) throws
    func string(forKey key: KeychainKey) throws -> String?
}

enum KeychainKey: String {
    case authToken

    var tag: String {
        let bundleIdentifier = Bundle.main.bundleIdentifier ?? "juliechildress.FayInterview"
        return bundleIdentifier + ".\(rawValue)"
    }

    var securityClass: CFString {
        switch self {
        case .authToken:
            kSecClassGenericPassword
        }
    }

    var baseQuery: [String: Any] {
        [
            kSecClass as String: securityClass,
            kSecAttrAccount as String: "fayIdentifier",
            kSecAttrService as String: tag
        ]
    }
}

final class KeychainService: KeychainServicing {
    func setString(_ string: String?, forKey key: KeychainKey) throws {
        var query = key.baseQuery
        if let string = string {
            let data = string.data(using: .utf8)!
            query[kSecValueData as String] = data
            SecItemDelete(query as CFDictionary)
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else {
                throw KeychainError.addFailed(status: status)
            }
        } else {
            SecItemDelete(query as CFDictionary)
        }
    }

    func string(forKey key: KeychainKey) throws -> String? {
        var query = key.baseQuery
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var value: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &value)
        guard status == errSecSuccess else {
            throw KeychainError.notFound
        }
        guard let data = value as? Data else {
            throw KeychainError.invalidData
        }
        return String(data: data, encoding: .utf8)
    }
}

enum KeychainError: Error, Equatable {
    case addFailed(status: OSStatus)
    case notFound
    case invalidData
}
