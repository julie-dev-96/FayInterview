//
//  APIService.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import Foundation

/// @mockable
public protocol APIRequesting {
    func request(_ endpoint: APIEndpoint) async throws -> Data
}

final class APIClient: APIRequesting {

    // This could be passed in as a "BaseURLProvider" for:
    // Supporting multiple baseURLs, unit testing and dev environments.
    // For time, I am leaving it as a String.
    let baseURLString: String
    let urlSession: URLSessionable
    let tokenProvider: AuthTokenProviding

    init(
        baseURLString: String = "https://node-api-for-candidates.onrender.com",
        urlSession: URLSessionable = URLSession.shared,
        tokenProvider: AuthTokenProviding = KeychainAuthTokenProvider()
    ) {
        self.baseURLString = baseURLString
        self.urlSession = urlSession
        self.tokenProvider = tokenProvider
    }

    func request(
        _ endpoint: APIEndpoint
    ) async throws -> Data {
        guard let baseURL: URL = URL(string: baseURLString) else { throw APIError.invalidURL }
        let token: String? = endpoint.requiresAuth ? tokenProvider.token : nil
        let request: URLRequest = endpoint.makeURLRequest(
            baseURL: baseURL,
            with: token
        )
        do {
            let (data, response) = try await urlSession.data(for: request)
            return try handleURLSessionDataAndResponse(
                data: data,
                response: response
            )
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.unknown
        }
    }

    private func handleURLSessionDataAndResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.unknown }
        switch httpResponse.statusCode {
        case 200...299:
            return data
        case 401:
            throw APIError.unauthorized
        case 400...499:
            throw APIError.general400
        case 500...599:
            throw APIError.general500
        default:
            throw APIError.unknown
        }
    }
}

/// @mockable
protocol URLSessionable {
    func data(
        for request: URLRequest,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)
}

extension URLSessionable {
    func data(
        for request: URLRequest
    ) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: nil)
    }
}

extension URLSession: URLSessionable {}
