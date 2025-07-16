//
//  AppointmentsView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import Observation
import SwiftUI

struct AppointmentsView: View {
    @State private var state: AppointmentsState

    init(
        appointmentsStore: AppointmentsStoring
    ) {
        self.state = AppointmentsState(
            appointmentsStore: appointmentsStore
        )
    }

    var body: some View {
        VStack(spacing: .none) {
            AppointmentsHeaderView(
                onAddButtonPressed: {
                    state.send(.newAppointmentHeaderTapped)
                }
            )

            AppointmentsTabView(
                selectedTab: $state.selectedTab,
                onUpcomingTabSelected: {
                    state.send(
                        .tabSelected(
                            .upcoming
                        )
                    )
                },
                onPastTabSelected: {
                    state.send(
                        .tabSelected(
                            .past
                        )
                    )
                }
            )

            switch state.viewState {
            case .loading:
                LoadingSpinnerView()
                    .task {
                        state.send(.fetchAppointments)
                    }
            case .fetched:
                switch state.selectedTab {
                case .past:
                    AppointmentsCardListView(
                        isUpcomingAppointments: false,
                        appointments: state.sortedAppointments.past
                    )
                case .upcoming:
                    AppointmentsCardListView(
                        isUpcomingAppointments: true,
                        appointments: state.sortedAppointments.upcoming
                    ) {
                        state.send(.joinAppointmentTapped)
                    }
                }
            }
        }
        .alert(
            LocalizedString.Appointments.fetchAppointmentsErrorTitle,
            isPresented: $state.shouldShowErrorAlert,
            actions: {
                Button(
                    LocalizedString.Common.retry
                ) {
                    state.send(.dismissErrorAlert(
                        retry: true
                    ))
                }

                Button(
                    LocalizedString.Common.ok,
                    role: .cancel
                ) {
                    state.send(
                        .dismissErrorAlert(retry: false)
                    )
                }
            },
            message: {
                Text(LocalizedString.Appointments.fetchAppointmentsErrorMessage)
            }
        )
    }
}

#Preview {
    let upcomingAppointments: [Appointment] = [
        Appointment.preview(
            start: DateComponents(year: 2025, month: 11, day: 8, hour: 11),
            end: DateComponents(year: 2025, month: 11, day: 8, hour: 12),
            type: "Follow up"
        ),
        Appointment.preview(
            start: DateComponents(year: 2025, month: 11, day: 24, hour: 11),
            end: DateComponents(year: 2025, month: 11, day: 24, hour: 12),
            type: "Follow up"
        ),
        Appointment.preview(
            start: DateComponents(year: 2025, month: 12, day: 16, hour: 11),
            end: DateComponents(year: 2025, month: 12, day: 16, hour: 12),
            type: "Follow up"
        ),
    ]
    let pastAppointments: [Appointment] = [
        Appointment.preview(
            start: DateComponents(year: 2025, month: 10, day: 16, hour: 11),
            end: DateComponents(year: 2025, month: 10, day: 16, hour: 12),
            type: "Follow up"
        ),
        Appointment.preview(
            start: DateComponents(year: 2025, month: 10, day: 24, hour: 11),
            end: DateComponents(year: 2025, month: 10, day: 24, hour: 12),
            type: "Follow up"
        ),
    ]

    let store: AppointmentsStore = .preview(
        hasFetchedAppointments: false,
        appointments: upcomingAppointments + pastAppointments
    )

    ZStack {
        DesignColor.Background.primary
            .ignoresSafeArea()
        AppointmentsView(
            appointmentsStore: store
        )
    }
}
