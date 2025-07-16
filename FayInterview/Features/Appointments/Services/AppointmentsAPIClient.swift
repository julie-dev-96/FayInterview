//
//  AppointmentsAPIClient.swift
//  FayInterview
//
//  Created by Julie Childress on 7/12/25.
//

import Foundation

// MARK: Protocol

/// @mockable
protocol AppointmentsAPIRequesting {
    func fetchAppointments() async throws -> [Appointment]
}

// MARK: Client

final class AppointmentsAPIClient: AppointmentsAPIRequesting {

    let apiClient: APIRequesting

    init(
        apiClient: APIRequesting = APIClient()
    ) {
        self.apiClient = apiClient
    }

    func fetchAppointments() async throws -> [Appointment] {
        do {
            let data = try await apiClient.request(Endpoint.fetchAppointments)
            let decoder: JSONDecoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let appointmentsResponse = try decoder.decode(AppointmentsAPIResponse.self, from: data)
            let appointments = appointmentsResponse.appointments.compactMap(Appointment.init(apiResponse:))
            return appointments
        } catch let error as APIError {
            switch error {
            case .general400,
                    .general500,
                    .unknown:
                throw AppointmentsError.networkError
            case .unauthorized:
                throw AppointmentsError.needsAuth
            case .invalidURL:
                throw AppointmentsError.internalError
            }
        } catch {
            throw AppointmentsError.internalError
        }
    }
}

// MARK: Endpoints

extension AppointmentsAPIClient {
    enum Endpoint {
        static let fetchAppointments: APIEndpoint = .init(
            path: "appointments",
            method: .get,
            body: nil,
            requiresAuth: true
        )
    }
}

// MARK: Errors

extension AppointmentsAPIClient {
    enum AppointmentsError: Error {
        case internalError
        case needsAuth
        case networkError
    }
}
