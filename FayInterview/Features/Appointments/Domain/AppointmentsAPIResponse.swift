//
//  AppointmentsAPIResponse.swift
//  FayInterview
//
//  Created by Julie Childress on 7/12/25.
//

import Foundation

// MARK: AppointmentsAPIResponse

struct AppointmentsAPIResponse: Decodable {
    let appointments: [AppointmentResponse]
}

// MARK: AppointmentResponse

struct AppointmentResponse: Decodable {
    let appointmentID, patientID, providerID, status: String
    let appointmentType: String
    let start, end: Date
    let durationInMinutes: Int?
    let recurrenceType: String?

    enum CodingKeys: String, CodingKey {
        case appointmentID = "appointment_id"
        case patientID = "patient_id"
        case providerID = "provider_id"
        case status
        case appointmentType = "appointment_type"
        case start, end
        case durationInMinutes = "duration_in_minutes"
        case recurrenceType = "recurrence_type"
    }
}
