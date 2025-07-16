//
//  APIClientTests.swift
//  FayInterview
//
//  Created by Julie Childress on 7/15/25.
//

import Foundation
import Testing

@testable import FayInterview

@Suite(
    "API Client Tests"
)
struct APIClientTests {
    var urlSession: URLSessionableMock = URLSessionableMock()
    var authTokenProvider: AuthTokenProvidingMock = AuthTokenProvidingMock()

    func makeAPIClient(
        baseURLString: String = "https://node-api-for-candidates.onrender.com"
    ) -> APIClient {
        .init(
            baseURLString: baseURLString,
            urlSession: urlSession,
            tokenProvider: authTokenProvider
        )
    }

    @Test(
        "Throws Error for Invalid URL"
    )
    func throwsErrorForInvalidURL() async throws {
        // GIVEN
        let apiClient = makeAPIClient(baseURLString: "")
        let endpoint: APIEndpoint = .init(
            path: "/signin",
            method: .post,
            requiresAuth: false
        )

        // THEN
        await #expect(
            throws: APIError.invalidURL,
            performing: { try await apiClient.request(endpoint) }
        )
    }

    @Test(
        "Provides Token when Auth is Required"
    )
    func providesTokenWhenAuthIsRequired() async throws {
        // GIVEN
        authTokenProvider.token = "mock-token"
        var token: String?
        urlSession.dataHandler = { request, _ in
            token = request.allHTTPHeaderFields?["Authorization"]
            let response: HTTPURLResponse = .init(
                url: URL(string: "mockURL")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (Data(), response)
        }
        let endpoint: APIEndpoint = .init(
            path: "/signin",
            method: .post,
            requiresAuth: true
        )
        let apiClient = makeAPIClient()

        // WHEN
        let _ = try await apiClient.request(endpoint)

        // THEN
        #expect(token == "Bearer mock-token")
    }

    @Test(
        "Does not provide Token when Auth is Required"
    )
    func doesNotProvideTokenWhenAuthIsRequired() async throws {
        // GIVEN
        authTokenProvider.token = "mock-token"
        var token: String?
        urlSession.dataHandler = { request, _ in
            token = request.allHTTPHeaderFields?["Authorization"]
            let response: HTTPURLResponse = .init(
                url: URL(string: "mockURL")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (Data(), response)
        }
        let endpoint: APIEndpoint = .init(
            path: "/signin",
            method: .post,
            requiresAuth: false
        )
        let apiClient = makeAPIClient()

        // WHEN
        let _ = try await apiClient.request(endpoint)

        // THEN
        #expect(token == nil)
    }

    @Test(
        "Throws Appropriate APIError",
        arguments: [
            (401, APIError.unauthorized),
            (400, APIError.general400),
            (500, APIError.general500),
            (300, APIError.unknown)
        ]
    )
    func throwsAppropriateError(
        statusCode: Int,
        expectedError: APIError
    ) async throws {
        // GIVEN
        urlSession.dataHandler = { _, _ in
            let response: HTTPURLResponse = .init(
                url: URL(string: "mockURL")!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )!
            return (Data(), response)
        }
        let endpoint = APIEndpoint(
            path: "/signin",
            method: .post,
            requiresAuth: false
        )
        let apiClient = makeAPIClient()

        // THEN
        await #expect(
            throws: expectedError,
            performing: { try await apiClient.request(endpoint)}
        )
    }
}
