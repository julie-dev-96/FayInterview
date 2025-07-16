//
//  AppointmentsSorter.swift
//  FayInterview
//
//  Created by Julie Childress on 7/12/25.
//

import Foundation

/// @mockable
protocol AppointmentsSorting {
    func sortAppointments(
        _ appointments: [Appointment],
        currentDate: Date
    ) -> SortedAppointments
}

extension AppointmentsSorting {
    func sortAppointments(_ appointments: [Appointment]) -> SortedAppointments {
        sortAppointments(appointments, currentDate: .now)
    }
}

final class AppointmentsSorter: AppointmentsSorting {
    func sortAppointments(
        _ appointments: [Appointment],
        currentDate: Date = .now
    ) -> SortedAppointments {
        let sortedAppointments: [Appointment] = appointments.sorted { $0.startDate < $1.startDate }
        let upcomingAppointments: [Appointment] = sortedAppointments.filter { $0.endDate > currentDate }
        let pastAppointments: [Appointment] = sortedAppointments.filter { $0.endDate <= currentDate }
        let reversedPastAppointments: [Appointment] = Array(pastAppointments.reversed())
        return .init(
            upcoming: upcomingAppointments,
            past: reversedPastAppointments
        )
    }
}
