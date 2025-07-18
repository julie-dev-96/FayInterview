//
//  AppointmentsState.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import Observation
import SwiftUI

// MARK: State

@Observable
final class AppointmentsState {

    // MARK: Published Properties

    var selectedTab: AppointmentTab
    var viewState: AppointmentsViewState {
        if appointmentsStore.hasFetchedAppointments || couldNotFetchAppointments {
            .fetched
        } else {
            .loading
        }
    }

    var sortedAppointments: SortedAppointments {
        appointmentsStore.sortedAppointments
    }

    var shouldShowErrorAlert: Bool
    var couldNotFetchAppointments: Bool

    // MARK: Private Properties

    private let appointmentsRouter: AppointmentsRouting
    private let appointmentsStore: AppointmentsStoring

    // MARK: Initial State

    init(
        appointmentsRouter: AppointmentsRouting,
        appointmentsStore: AppointmentsStoring
    ) {
        self.selectedTab = .upcoming
        self.appointmentsRouter = appointmentsRouter
        self.appointmentsStore = appointmentsStore

        self.shouldShowErrorAlert = false
        self.couldNotFetchAppointments = false
    }

    // MARK: Intent Handling

    func send(_ intent: AppointmentsIntent) {
        switch intent {
        case .fetchAppointments:
            fetchAppointments()
        case .newAppointmentHeaderTapped:
            navigateToNewAppointment()
        case .tabSelected(let tab):
            handleTabSelected(tab)
        case .joinAppointmentTapped:
            joinAppointment()
        case .dismissErrorAlert(let retry):
            handleDismissErrorAlert(retry: retry)
        }
    }

    private func fetchAppointments() {
        Task {
            do {
                try await appointmentsStore.fetchAppointments()
            } catch {
                await showErrorAlert()
            }
        }
    }

    @MainActor
    private func showErrorAlert() {
        shouldShowErrorAlert = true
    }

    private func navigateToNewAppointment() {
        appointmentsRouter.navigateToCreateAppointment()
    }

    private func handleTabSelected(_ tab: AppointmentTab) {
        self.selectedTab = tab
    }

    private func joinAppointment() {
        // TODO: Handle Join Appointment Tapped
        print("Join Appointment Tapped")
    }

    private func handleDismissErrorAlert(retry: Bool) {
        if retry {
            shouldShowErrorAlert = false
            fetchAppointments()
        } else {
            shouldShowErrorAlert = false
            couldNotFetchAppointments = true
        }
    }
}

// MARK: ViewState

enum AppointmentsViewState {
    case loading
    case fetched
}

// MARK: Intents

enum AppointmentsIntent {
    case fetchAppointments
    case newAppointmentHeaderTapped
    case tabSelected(AppointmentTab)
    case joinAppointmentTapped
    case dismissErrorAlert(retry: Bool)
}

// MARK: Appointment Tabs

enum AppointmentTab {
    case past
    case upcoming
}
