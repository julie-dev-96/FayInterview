//
//  KeychainAuthTokenProviderTests.swift
//  FayInterview
//
//  Created by Julie Childress on 7/15/25.
//

import Testing

@testable import FayInterview

@Suite(
    "Keychain Auth Token Provider Tests"
)
struct KeychainAuthTokenProviderTests {
    let keychainMock = KeychainServicingMock()
    var keychainAuthTokenProvider: KeychainAuthTokenProvider!

    init() async throws {
        keychainAuthTokenProvider = KeychainAuthTokenProvider(
            keychain: keychainMock
        )
    }

    @Test(
        "Retrieves token from Keychain"
    )
    func retrievesTokenFromKeychain() {
        // GIVEN
        keychainMock.stringHandler = { _ in "mockToken" }

        // WHEN
        let token = keychainAuthTokenProvider.token

        // THEN
        #expect(token == "mockToken")
    }
}
