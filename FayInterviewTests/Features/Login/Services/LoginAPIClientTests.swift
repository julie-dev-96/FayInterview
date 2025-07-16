//
//  LoginAPIClientTests.swift
//  FayInterview
//
//  Created by Julie Childress on 7/15/25.
//

import Testing

@testable import FayInterview

@Suite("LoginAPIClient Tests")
struct LoginAPIClientTests {
    let apiClientMock = APIRequestingMock()
    var loginAPIClient: LoginAPIClient!

    init() {
        loginAPIClient = .init(
            apiClient: apiClientMock
        )
    }

    @Test("Successfully Logs In")
    func successfulLogin() async throws {
        // GIVEN
        apiClientMock.requestHandler = { _ in
            """
            {
              "token": "mockToken"
            }
            """.data(using: .utf8)!
        }
        let loginRequest: LoginRequest = .init(
            username: "john",
            password: "12345"
        )

        // WHEN
        let actualResponse = try await loginAPIClient.login(loginRequest: loginRequest)

        // THEN
        #expect(actualResponse.token == "mockToken")
    }

    @Test("Throws API Errors")
    func throwsAPIErrors() async throws {
        // GIVEN
        apiClientMock.requestHandler = { _ in throw APIError.general400 }
        let loginRequest: LoginRequest = .init(
            username: "john",
            password: "12345"
        )

        // THEN
        await #expect(
            throws: APIError.general400,
            performing: { try await loginAPIClient.login(loginRequest: loginRequest) }
        )
    }
}
