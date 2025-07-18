//
//  AppointmentsRouter.swift
//  FayInterview
//
//  Created by Julie Childress on 7/17/25.
//

import Observation
import SwiftUI

/// @mockable
protocol AppointmentsRouting {
    var path: Binding<[Route]> { get set }

    func navigateToCreateAppointment()
}

@Observable
final class AppointmentsRouter: AppointmentsRouting {
    var path: Binding<[Route]>

    init(path: Binding<[Route]>) {
        self._path = path
    }

    func navigateToCreateAppointment() {
        path.wrappedValue.append(.createAppointment)
    }
}
