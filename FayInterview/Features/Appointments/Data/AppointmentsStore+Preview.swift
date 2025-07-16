//
//  AppointmentsStore+Preview.swift
//  FayInterview
//
//  Created by Julie Childress on 7/13/25.
//

#if DEBUG
final class PreviewAppointmentsAPI: AppointmentsAPIRequesting {
    let appointments: [Appointment]

    init(appointments: [Appointment]) {
        self.appointments = appointments
    }

    func fetchAppointments() async throws -> [Appointment] {
        return appointments
    }
}

extension AppointmentsStore {
    static func preview(
        hasFetchedAppointments: Bool = true,
        appointments: [Appointment] = []
    ) -> AppointmentsStore {
        return .init(
            hasFetchedAppointments: hasFetchedAppointments,
            apiClient: PreviewAppointmentsAPI(appointments: appointments),
            appointmentsSorter: AppointmentsSorter()
        )
    }
}
#endif
