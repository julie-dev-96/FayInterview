//
//  AppointmentsStore.swift
//  FayInterview
//
//  Created by Julie Childress on 7/13/25.
//

import Observation

/// @mockable
protocol AppointmentsStoring {
    var hasFetchedAppointments: Bool { get }
    var sortedAppointments: SortedAppointments { get }

    func fetchAppointments() async throws
}

@Observable
final class AppointmentsStore: AppointmentsStoring {
    var hasFetchedAppointments: Bool
    var sortedAppointments: SortedAppointments

    let apiClient: AppointmentsAPIRequesting
    let appointmentsSorter: AppointmentsSorting

    init(
        hasFetchedAppointments: Bool = false,
        sortedAppointments: SortedAppointments = .init(upcoming: [], past: []),
        apiClient: AppointmentsAPIRequesting = AppointmentsAPIClient(),
        appointmentsSorter: AppointmentsSorting = AppointmentsSorter()
    ) {
        self.hasFetchedAppointments = hasFetchedAppointments
        self.sortedAppointments = sortedAppointments

        self.apiClient = apiClient
        self.appointmentsSorter = appointmentsSorter
    }

    func fetchAppointments() async throws {
        let appointments: [Appointment] = try await apiClient.fetchAppointments()
        self.sortedAppointments = appointmentsSorter.sortAppointments(appointments)
        self.hasFetchedAppointments = true
    }
}
