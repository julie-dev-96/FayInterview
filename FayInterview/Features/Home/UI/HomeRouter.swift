//
//  HomeRouter.swift
//  FayInterview
//
//  Created by Julie Childress on 7/17/25.
//

import Observation
import SwiftUI

/// @mockable
protocol HomeRouting {
    var path: Binding<[Route]> { get set }
}

@Observable
final class HomeRouter: HomeRouting {
    var path: Binding<[Route]>

    init(path: Binding<[Route]>) {
        self.path = path
    }
}
