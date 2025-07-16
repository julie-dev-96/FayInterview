//
//  Appointment.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import Foundation

struct Appointment: Identifiable {
    let id: String
    let startDate: Date
    let endDate: Date
    let type: String
    let provider: String

    init(
        id: String,
        startDate: Date,
        endDate: Date,
        type: String
    ) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.type = type
        self.provider = "Jane Williams, RD"
    }

    init(apiResponse: AppointmentResponse) {
        self.id = apiResponse.appointmentID
        self.startDate = apiResponse.start
        self.endDate = apiResponse.end
        self.type = apiResponse.appointmentType
        self.provider = "Jane Williams, RD" // apiResponse.metadata.providerName
    }
}

extension Appointment {
    var monthString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: startDate).uppercased()
    }

    var dayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: startDate)
    }

    var startTimeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: startDate)
    }

    var fullTimeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        let timeZoneAbbreviationString = TimeZone.current.abbreviation()?.localizedUppercase
        var fullTimeString = startDateString + " - " + endDateString
        if let timeZoneAbbreviationString {
            fullTimeString += " (" + timeZoneAbbreviationString + ")"
        }
        return fullTimeString
    }

    var fullDescription: String {
        LocalizedString.Appointment.description(
            appointmentType: type,
            provider: provider
        )
    }
}
