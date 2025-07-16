//
//  RootView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/13/25.
//

import SwiftUI

enum RootScreen {
    case login
    case home
    case welcome
}

struct RootView: View {
    @State private var appointmentsStore: AppointmentsStore = .init()
    @State private var authStore = AuthStore(authStatus: .needsAuth)
    @State private var hasShownWelcomeScreen = false
    @State private var shouldAnimateWelcomeName = false

    var currentScreen: RootScreen {
        switch authStore.authStatus {
        case .needsAuth,
                .authenticationFailed:
                .login

        case .authenticated:
            hasShownWelcomeScreen ? .home : .welcome
        }
    }

    var body: some View {
        ZStack {
            contentView
        }
        .id(currentScreen)
        .animation(.easeInOut(duration: 0.5), value: currentScreen)
    }

    @ViewBuilder
    private var contentView: some View {
        switch currentScreen {
        case .login:
            LoginView(
                authStore: authStore
            )

        case .home:
            HomeView(
                appointmentsStore: appointmentsStore
            )

        case .welcome:
            WelcomeView(
                shouldAnimateName: $shouldAnimateWelcomeName,
                name: authStore.username,
            ) {
                hasShownWelcomeScreen = true
            }

        }
    }
}
