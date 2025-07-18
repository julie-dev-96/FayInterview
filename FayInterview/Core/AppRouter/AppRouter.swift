//
//  AppRouter.swift
//  FayInterview
//
//  Created by Julie Childress on 7/17/25.
//

import Observation

/// @mockable
protocol AppRouting {
    var path: [Route] { get set }
}

// MARK: Route Definitions

enum Route: Hashable {
    case createAppointment
}

@Observable
final class AppRouter: AppRouting {
    var path: [Route] = []
}
