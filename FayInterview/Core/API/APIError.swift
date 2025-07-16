//
//  APIError.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

public enum APIError: Error {
    case general400
    case general500
    case invalidURL
    case unauthorized
    case unknown
}
