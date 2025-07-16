//
//  LoginAPIClient.swift
//  FayInterview
//
//  Created by Julie Childress on 7/13/25.
//

import Foundation

// MARK: Protocol

/// @mockable
protocol LoginAPIRequesting {
    func login(
        loginRequest: LoginRequest
    ) async throws -> LoginResponse
}

// MARK: Client

final class LoginAPIClient: LoginAPIRequesting {

    let apiClient: APIRequesting

    init(
        apiClient: APIRequesting = APIClient()
    ) {
        self.apiClient = apiClient
    }

    func login(
        loginRequest: LoginRequest
    ) async throws -> LoginResponse {
        var loginEndpoint = Endpoint.signin
        do {
            loginEndpoint.body = try JSONEncoder().encode(loginRequest)
            let loginData = try await apiClient.request(loginEndpoint)
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: loginData)
            return loginResponse
        } catch {
            throw error
        }
    }
}

// MARK: Endpoints

extension LoginAPIClient {
    enum Endpoint {
        static let signin: APIEndpoint = .init(
            path: "signin",
            method: .post,
            body: nil,
            requiresAuth: false
        )
    }
}
