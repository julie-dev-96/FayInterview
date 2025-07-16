//
//  AuthTokenProvider.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

/// @mockable
protocol AuthTokenProviding {
    var token: String? { get }
}

final class KeychainAuthTokenProvider: AuthTokenProviding {
    let keychain: KeychainServicing

    init(
        keychain: KeychainServicing = KeychainService()
    ) {
        self.keychain = keychain
    }

    var token: String? {
        try? keychain.string(forKey: .authToken)
    }
}

