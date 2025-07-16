//
//  AuthStoreTests.swift
//  FayInterview
//
//  Created by Julie Childress on 7/15/25.
//

import Testing

@testable import FayInterview

@Suite("AuthStore Tests")
struct AuthStoreTests {
    let loginAPIClientMock = LoginAPIRequestingMock()
    let keychainServiceMock = KeychainServicingMock()
    var authStore: AuthStore!

    init() async throws {
        authStore = .init(
            authStatus: .needsAuth,
            username: "",
            loginAPIClient: loginAPIClientMock,
            keychain: keychainServiceMock
        )
    }

    @Test("Successful Authentication")
    func successfulAuthentication() async throws {
        // GIVEN
        loginAPIClientMock.loginHandler = { _ in .init(token: "testToken") }
        keychainServiceMock.setStringHandler = { _, _ in }

        // WHEN
        try await authStore.login(
            username: "username",
            password: "password"
        )

        // THEN
        #expect(loginAPIClientMock.loginCallCount == 1)
        #expect(keychainServiceMock.setStringCallCount == 1)
        #expect(authStore.authStatus == .authenticated)
        #expect(authStore.username == "username")
    }

    @Test("Throws when LoginAPIClient Fails")
    func failsOnLoginAPIClient() async throws {
        // GIVEN
        loginAPIClientMock.loginHandler = { _ in throw APIError.general500 }
        keychainServiceMock.setStringHandler = { _, _ in }

        // THEN
        await #expect(
            throws: APIError.general500,
            performing: { try await authStore.login(username: "username", password: "password") }
        )
    }

    @Test("Throws when KeychainService Fails")
    func failsOnKeychainService() async throws {
        // GIVEN
        loginAPIClientMock.loginHandler = { _ in .init(token: "testToken") }
        keychainServiceMock.setStringHandler = { _, _ in throw KeychainError.invalidData }

        // THEN
        await #expect(
            throws: KeychainError.invalidData,
            performing: { try await authStore.login(username: "username", password: "password") }
        )
    }
}
