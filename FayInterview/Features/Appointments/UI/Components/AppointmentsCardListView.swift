//
//  AppointmentsCardListView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import SwiftUI

struct AppointmentsCardListView: View {
    let isUpcomingAppointments: Bool
    let appointments: [Appointment]
    let onNearestAppointmentTapped: (() -> Void)?

    init(
        isUpcomingAppointments: Bool,
        appointments: [Appointment],
        onNearestAppointmentTapped: (() -> Void)? = nil
    ) {
        self.isUpcomingAppointments = isUpcomingAppointments
        self.appointments = appointments
        self.onNearestAppointmentTapped = onNearestAppointmentTapped
    }

    var body: some View {
        let enumeratedAppointments = Array(appointments.enumerated())
        List(enumeratedAppointments, id: \.element.id) { index, appointment in
            let isFirstUpcomingAppointment: Bool = isUpcomingAppointments && index == 0
            let time: String = isFirstUpcomingAppointment ? appointment.fullTimeString : appointment.startTimeString
            let description: String = isFirstUpcomingAppointment ? appointment.fullDescription : appointment.type
            AppointmentsCardView(
                month: appointment.monthString,
                day: appointment.dayString,
                time: time,
                description: description,
                isNearestAppointment: isFirstUpcomingAppointment,
                onJoinAppointmentTapped: onNearestAppointmentTapped
            )
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .padding(.vertical, -DesignPadding.small)
    }
}

#Preview("Upcoming Appointments") {
    let appointments: [Appointment] = [
        Appointment.preview(
            start: DateComponents(year: 2025, month: 11, day: 8, hour: 11),
            end: DateComponents(year: 2025, month: 11, day: 8, hour: 12),
            type: "Follow up"
        ),
        Appointment.preview(
            start: DateComponents(year: 2025, month: 11, day: 24, hour: 11),
            end: DateComponents(year: 2025, month: 11, day: 24, hour: 12),
            type: "Follow up"
        ),
        Appointment.preview(
            start: DateComponents(year: 2025, month: 12, day: 16, hour: 11),
            end: DateComponents(year: 2025, month: 12, day: 16, hour: 12),
            type: "Follow up"
        ),
    ]
    AppointmentsCardListView(
        isUpcomingAppointments: true,
        appointments: appointments,
        onNearestAppointmentTapped: { print("onNearestAppointmentTapped") }
    )
}

#Preview("Past Appointments") {
    let appointments: [Appointment] = [
        Appointment.preview(
            start: DateComponents(year: 2025, month: 10, day: 16, hour: 11),
            end: DateComponents(year: 2025, month: 10, day: 16, hour: 12),
            type: "Follow up"
        ),
        Appointment.preview(
            start: DateComponents(year: 2025, month: 10, day: 24, hour: 11),
            end: DateComponents(year: 2025, month: 10, day: 24, hour: 12),
            type: "Follow up"
        ),
    ]
    AppointmentsCardListView(
        isUpcomingAppointments: false,
        appointments: appointments
    )
}
