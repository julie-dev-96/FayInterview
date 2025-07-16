//
//  AuthStore.swift
//  FayInterview
//
//  Created by Julie Childress on 7/13/25.
//

import Observation

/// @mockable
protocol AuthStoring {
    var authStatus: AuthStatus { get }

    func login(
        username: String,
        password: String
    ) async throws
}

@Observable
final class AuthStore: AuthStoring {
    var authStatus: AuthStatus
    var username: String

    private let loginAPIClient: LoginAPIRequesting
    private let keychain: KeychainServicing

    init(
        authStatus: AuthStatus,
        username: String = "",
        loginAPIClient: LoginAPIRequesting = LoginAPIClient(),
        keychain: KeychainServicing = KeychainService()
    ) {
        self.authStatus = authStatus
        self.username = username
        self.loginAPIClient = loginAPIClient
        self.keychain = keychain
    }

    func login(
        username: String,
        password: String
    ) async throws {
        let loginRequest: LoginRequest = .init(
            username: username,
            password: password
        )
        do {
            let loginResponse = try await loginAPIClient.login(loginRequest: loginRequest)
            try keychain.setString(
                loginResponse.token, forKey: .authToken
            )
            self.username = loginRequest.username // typically would be from the response.
            self.authStatus = .authenticated
        } catch {
            self.authStatus = .authenticationFailed
            throw error
        }
    }
}

enum AuthStatus {
    case needsAuth
    case authenticated
    case authenticationFailed
}
