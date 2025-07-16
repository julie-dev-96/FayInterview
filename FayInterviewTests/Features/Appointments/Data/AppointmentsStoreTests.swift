//
//  AppointmentsStoreTests.swift
//  FayInterview
//
//  Created by Julie Childress on 7/15/25.
//

import Testing

@testable import FayInterview

@Suite(
    "Appointments Store Tests"
)
struct AppointmentsStoreTests {
    var apiClientMock: AppointmentsAPIRequestingMock = .init()
    var appointmentsSorterMock: AppointmentsSortingMock = .init()
    var appointmentsStore: AppointmentsStore!

    init() {
        appointmentsStore = .init(
            hasFetchedAppointments: false,
            sortedAppointments: .init(upcoming: [], past: []),
            apiClient: apiClientMock,
            appointmentsSorter: appointmentsSorterMock
        )
    }

    @Test(
        "Calls fetchAppointments API"
    )
    func callsFetchAppointmentsAPI() async throws {
        // GIVEN
        apiClientMock.fetchAppointmentsHandler = { return [] }
        appointmentsSorterMock.sortAppointmentsHandler = { _, _ in SortedAppointments(upcoming: [], past: []) }

        // WHEN
        try await appointmentsStore.fetchAppointments()

        // THEN
        #expect(apiClientMock.fetchAppointmentsCallCount == 1)
    }

    @Test(
        "Calls Appointments Sorter"
    )
    func callsAppointmentSorter() async throws {
        // GIVEN
        apiClientMock.fetchAppointmentsHandler = { return [] }
        appointmentsSorterMock.sortAppointmentsHandler = { _, _ in SortedAppointments(upcoming: [], past: []) }

        // WHEN
        try await appointmentsStore.fetchAppointments()

        // THEN
        #expect(appointmentsSorterMock.sortAppointmentsCallCount == 1)
    }

    @Test(
        "Updates HasFetchedAppointments and SortedAppointments"
    )
    func updatesItsValues() async throws {
        // GIVEN
        let sortedAppointments: SortedAppointments = .init(
            upcoming: [
                .init(
                    id: "1",
                    startDate: .distantPast,
                    endDate: .distantFuture,
                    type: "Follow-up"
                )
            ],
            past: [
                .init(
                    id: "2",
                    startDate: .distantPast,
                    endDate: .distantFuture,
                    type: "Follow-up"
                )
            ]
        )
        apiClientMock.fetchAppointmentsHandler = { return [] }
        appointmentsSorterMock.sortAppointmentsHandler = { _, _ in sortedAppointments }

        // WHEN
        try await appointmentsStore.fetchAppointments()

        // THEN
        #expect(appointmentsStore.sortedAppointments.upcoming[0].id == "1")
        #expect(appointmentsStore.sortedAppointments.past[0].id == "2")
        #expect(appointmentsStore.hasFetchedAppointments)
    }
}
