//
//  HomeView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/12/25.
//

import SwiftUI

struct HomeView: View {
    @State private var state: HomeState

    init(
        homeRouter: HomeRouting,
        appointmentsStore: AppointmentsStoring
    ) {
        self.state = HomeState(
            homeRouter: homeRouter,
            appointmentsStore: appointmentsStore
        )
    }

    var body: some View {
        TabView {
            ForEach(state.tabs, id: \.self) { tab in
                let item: HomeTab.Item = tab.item(
                    isSelected: tab == state.selectedTab
                )

                Tab(
                    content: {
                        switch tab {
                        case .appointments:
                            let appointmentsRouter = AppointmentsRouter(path: state.homeRouter.path)
                            AppointmentsView(
                                appointmentsRouter: appointmentsRouter,
                                appointmentsStore: state.appointmentsStore
                            )
                        case .chat:
                            Text(LocalizedString.Home.chat)
                                .font(DesignFont.titleH1)
                                .foregroundStyle(DesignColor.Text.primary)
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity
                                )
                        case .journal:
                            Text(LocalizedString.Home.journal)
                                .font(DesignFont.titleH1)
                                .foregroundStyle(DesignColor.Text.primary)
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity
                                )
                        case .profile:
                            Text(LocalizedString.Home.profile)
                                .font(DesignFont.titleH1)
                                .foregroundStyle(DesignColor.Text.primary)
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity
                                )
                        }
                    },
                    label: {
                        HomeTabItemView(
                            tab: tab,
                            tabItem: item
                        )
                    }
                )
            }
        }
    }
}

#Preview {
    @Previewable @State var path: [Route] = []
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
            start: DateComponents(year: 2023, month: 10, day: 16, hour: 11),
            end: DateComponents(year: 2023, month: 10, day: 16, hour: 12),
            type: "Follow up"
        ),
        Appointment.preview(
            start: DateComponents(year: 2023, month: 10, day: 24, hour: 11),
            end: DateComponents(year: 2023, month: 10, day: 24, hour: 12),
            type: "Follow up"
        ),
    ]

    let appointmentsStore: AppointmentsStore = .preview(
        hasFetchedAppointments: false,
        appointments: upcomingAppointments + pastAppointments
    )

    HomeView(
        homeRouter: HomeRouter(path: $path),
        appointmentsStore: appointmentsStore
    )
}
