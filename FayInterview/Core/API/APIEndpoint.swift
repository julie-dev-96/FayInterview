//
//  APIEndpoint.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import Foundation

public struct APIEndpoint {
    let path: String
    let method: HTTPMethod
    var body: Data?
    let requiresAuth: Bool
}

public enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

extension APIEndpoint {
    func makeURLRequest(
        baseURL: URL,
        with token: String? = nil
    ) -> URLRequest {
        let url = baseURL.appending(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if requiresAuth, let token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return request
    }
}
