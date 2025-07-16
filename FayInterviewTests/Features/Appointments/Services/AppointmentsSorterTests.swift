//
//  AppointmentsSorterTests.swift
//  FayInterview
//
//  Created by Julie Childress on 7/15/25.
//

import Foundation
import Testing

@testable import FayInterview

@Suite("Appointments Sorter Tests")
struct AppointmentsSorterTests {
    var appointmentsSorter: AppointmentsSorter!

    init() {
        appointmentsSorter = AppointmentsSorter()
    }

    @Test("Sorts Appointments")
    func sortsAppointments() {
        // GIVEN
        var appointments: [Appointment] = []
        for day in 1...10 {
            let startDate: Date = {
                var components: DateComponents = .init(year: 2024, month: 8, day: day, hour: 17, minute: 45)
                components.timeZone = .gmt
                return Calendar.current.date(from: components)!
            }()
            let endDate: Date = {
                var components: DateComponents = .init(year: 2024, month: 8, day: day, hour: 18, minute: 30)
                components.timeZone = .gmt
                return Calendar.current.date(from: components)!
            }()
            appointments.append(
                Appointment(
                    id: "\(day)",
                    startDate: startDate,
                    endDate: endDate,
                    type: "type"
                )
            )
        }

        appointments.shuffle()
        let currentDate: Date = {
            var components: DateComponents = .init(year: 2024, month: 8, day: 5, hour: 23, minute: 59)
            components.timeZone = .gmt
            return Calendar.current.date(from: components)!
        }()

        // WHEN
        let sortedAppointments: SortedAppointments = appointmentsSorter.sortAppointments(
            appointments,
            currentDate: currentDate
        )

        // THEN
        #expect(sortedAppointments.upcoming.count == 5)
        #expect(sortedAppointments.past.count == 5)

        let upcoming = sortedAppointments.upcoming
        #expect(upcoming[0].id == "6")
        #expect(upcoming[1].id == "7")
        #expect(upcoming[2].id == "8")
        #expect(upcoming[3].id == "9")
        #expect(upcoming[4].id == "10")

        let past = sortedAppointments.past
        #expect(past[0].id == "5")
        #expect(past[1].id == "4")
        #expect(past[2].id == "3")
        #expect(past[3].id == "2")
        #expect(past[4].id == "1")
    }
}
