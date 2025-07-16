//
//  AppointmentsStateTests.swift
//  FayInterview
//
//  Created by Julie Childress on 7/15/25.
//

import Testing

@testable import FayInterview

@Suite("AppointmentsState Tests")
struct AppointmentsStateTests {

    let appointmentsStoreMock = AppointmentsStoringMock()
    var appointmentsState: AppointmentsState!

    init() {
        appointmentsState = .init(
            appointmentsStore: appointmentsStoreMock
        )
    }

    @Test("Fetch Appointments Intent fetches appointments")
    func fetchesAppointments() async throws {
        await withCheckedContinuation { continuation in
            // GIVEN
            appointmentsStoreMock.fetchAppointmentsHandler = {
                continuation.resume()
            }

            // WHEN
            appointmentsState.send(.fetchAppointments)
        }

        // THEN
        #expect(appointmentsStoreMock.fetchAppointmentsCallCount == 1)
    }

    @Test("Tab Selected Updates Tab")
    func tabSelected() {
        // GIVEN
        appointmentsState.selectedTab = .upcoming

        // WHEN
        appointmentsState.send(.tabSelected(.past))

        // THEN
        appointmentsState.selectedTab = .past
    }

    @Test("Dismiss Error Alert without Retry Stops Loading")
    func dismissErrorAlertWithoutRetry() {
        // GIVEN
        appointmentsState.shouldShowErrorAlert = true

        // WHEN
        appointmentsState.send(.dismissErrorAlert(retry: false))

        // THEN
        #expect(appointmentsState.couldNotFetchAppointments)
        #expect(!appointmentsState.shouldShowErrorAlert)
    }

    @Test("Dismiss Error Alert with Retry Fetches Appointments")
    func dismissErrorAlertWithRetry() async {
        await withCheckedContinuation { continuation in
            // GIVEN
            appointmentsState.shouldShowErrorAlert = true
            appointmentsStoreMock.fetchAppointmentsHandler = { continuation.resume() }

            // WHEN
            appointmentsState.send(.dismissErrorAlert(retry: true))
        }

        // THEN
        #expect(!appointmentsState.couldNotFetchAppointments)
        #expect(!appointmentsState.shouldShowErrorAlert)
        #expect(appointmentsStoreMock.fetchAppointmentsCallCount == 1)
    }
}
