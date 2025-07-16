//
//  LocalizedString.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import Foundation

public enum LocalizedString {
    public enum Appointment {
        static func description(appointmentType: String, provider: String) -> String {
            let localizedFormat = NSLocalizedString("appointment.description", comment: "Format: {appointmentType} with {provider}")
            return String(format: localizedFormat, appointmentType, provider)
        }
    }

    public enum Appointments {
        static let buttonHeader = String(localized: "appointments.buttonHeader")
        static let fetchAppointmentsErrorTitle = String(localized: "appointments.fetchAppointmentsErrorTitle")
        static let fetchAppointmentsErrorMessage = String(localized: "appointments.fetchAppointmentsErrorMessage")
        static let header = String(localized: "appointments.header")
        static let joinButton = String(localized: "appointments.joinButton")
        static let pastTab = String(localized: "appointments.pastTab")
        static let upcomingTab = String(localized: "appointments.upcomingTab")
    }

    public enum Common {
        static let `continue` = String(localized: "common.continue")
        static let ok = String(localized: "common.ok")
        static let retry = String(localized: "common.retry")
    }

    public enum Home {
        static let appointments = String(localized: "home.appointments")
        static let chat = String(localized: "home.chat")
        static let journal = String(localized: "home.journal")
        static let profile = String(localized: "home.profile")
    }

    public enum Login {
        static let login = String(localized: "login.login")
        static let password = String(localized: "login.password")
        static let passwordPlaceholder = String(localized: "login.passwordPlaceholder")
        static let username = String(localized: "login.username")
        static let usernamePlaceholder = String(localized: "login.usernamePlaceholder")

        public enum Alert {
            static let invalidCredentialsTitle = String(localized: "login.alert.invalidCredentialsTitle")
            static let invalidCredentialsMessage = String(localized: "login.alert.invalidCredentialsMessage")
        }
    }

    public enum Welcome {
        static let title = String(localized: "welcome.title")
    }
}
