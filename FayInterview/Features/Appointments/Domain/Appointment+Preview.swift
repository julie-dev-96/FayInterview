//
//  Appointment+Preview.swift
//  FayInterview
//
//  Created by Julie Childress on 7/12/25.
//

#if DEBUG
import Foundation

extension Appointment {
    static func preview(
        id: String = UUID().uuidString,
        start: DateComponents,
        end: DateComponents,
        type: String,
        calendar: Calendar = .current
    ) -> Appointment {
        let startDate = calendar.date(from: start)!
        let endDate = calendar.date(from: end)!
        return Appointment(id: id, startDate: startDate, endDate: endDate, type: type)
    }
}
#endif

