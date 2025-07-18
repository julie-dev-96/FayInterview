//
//  HomeState.swift
//  FayInterview
//
//  Created by Julie Childress on 7/12/25.
//

import Observation

// MARK: State

@Observable
final class HomeState {

    // MARK: Published Properties

    let tabs: [HomeTab]
    var selectedTab: HomeTab

    var homeRouter: HomeRouting
    let appointmentsStore: AppointmentsStoring

    // MARK: Initial State

    init(
        homeRouter: HomeRouting,
        appointmentsStore: AppointmentsStoring
    ) {
        // Not using .allCases as that would implicitly decide order of UI.
        // It's safer to explicitly put the order here rather than rely on order being right within the Enum.
        self.tabs = [.appointments, .chat, .journal, .profile]
        self.selectedTab = HomeTab.appointments

        self.homeRouter = homeRouter
        self.appointmentsStore = appointmentsStore
    }
}

// MARK: Tabs

enum HomeTab {
    case appointments
    case chat
    case journal
    case profile
}

// MARK: Tab Items

extension HomeTab {
    struct Item: Equatable {
        let isSelected: Bool
        let name: String

        func designIcon(for tab: HomeTab) -> DesignIcon {
            switch tab {
            case .appointments:
                isSelected ? .calendarFilled : .calendar
            case .chat:
                DesignIcon.chats
            case .journal:
                DesignIcon.notebookText
            case .profile:
                DesignIcon.user
            }
        }
    }

    func item(isSelected: Bool) -> Item {
        switch self {
        case .appointments:
            Item(
                isSelected: isSelected,
                name: LocalizedString.Home.appointments
            )
        case .chat:
            Item(
                isSelected: isSelected,
                name: LocalizedString.Home.chat
            )
        case .journal:
            Item(
                isSelected: isSelected,
                name: LocalizedString.Home.journal
            )
        case .profile:
            Item(
                isSelected: isSelected,
                name: LocalizedString.Home.profile
            )
        }
    }
}
