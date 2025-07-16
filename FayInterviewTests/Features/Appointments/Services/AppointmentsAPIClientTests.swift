//
//  AppointmentsAPIClientTests.swift
//  FayInterview
//
//  Created by Julie Childress on 7/15/25.
//

import Foundation
import Testing

@testable import FayInterview

@Suite("AppointmentsAPIClientTests")
struct AppointmentsAPIClientTests {
    let apiClientMock: APIRequestingMock = .init()
    var appointmentsAPIClient: AppointmentsAPIClient!

    init() {
        appointmentsAPIClient = .init(apiClient: apiClientMock)
    }

    @Test("Returns Appointment Array")
    func returnsAppointmentArray() async throws {
        // GIVEN
        apiClientMock.requestHandler = { _ in
            """
            {
                "appointments": [
                    {
                        "appointment_id": "mock_id",
                        "patient_id": "1",
                        "provider_id": "100",
                        "status": "Scheduled",
                        "appointment_type": "mock_appointment_type",
                        "start": "2024-08-10T17:45:00Z",
                        "end": "2024-08-10T18:30:00Z",
                        "duration_in_minutes": 45,
                        "recurrence_type": "Weekly"
                    }
                ]
            }
            """.data(using: .utf8)!
        }
        let expectedStartDate: Date = {
            var components: DateComponents = .init(year: 2024, month: 8, day: 10, hour: 17, minute: 45)
            components.timeZone = .gmt
            return Calendar.current.date(from: components)!
        }()
        let expectedEndDate: Date = {
            var components: DateComponents = .init(year: 2024, month: 8, day: 10, hour: 18, minute: 30)
            components.timeZone = .gmt
            return Calendar.current.date(from: components)!
        }()

        // WHEN
        let actualAppointments = try await appointmentsAPIClient.fetchAppointments()

        // THEN
        #expect(actualAppointments.count == 1)
        let appointment = actualAppointments[0]
        #expect(appointment.id == "mock_id")
        #expect(appointment.startDate == expectedStartDate)
        #expect(appointment.endDate == expectedEndDate)
        #expect(appointment.type == "mock_appointment_type")
    }

    typealias AppointmentsError = AppointmentsAPIClient.AppointmentsError

    @Test(
        "Throws Correct Error",
        arguments: [
            (APIError.general400, AppointmentsError.networkError),
            (APIError.general500, AppointmentsError.networkError),
            (APIError.unknown, AppointmentsError.networkError),
            (APIError.unauthorized, AppointmentsError.needsAuth),
            (APIError.invalidURL, AppointmentsError.internalError)
        ]
    )
    func throwsCorrectError(
        apiError: APIError,
        expectedError: AppointmentsError
    ) async throws {
        // GIVEN
        apiClientMock.requestHandler = { _ in
            throw apiError
        }

        // THEN
        await #expect(
            throws: expectedError,
            performing: { try await appointmentsAPIClient.fetchAppointments() }
        )
    }
}

/*
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
 */
