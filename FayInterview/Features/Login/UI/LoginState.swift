//
//  LoginState.swift
//  FayInterview
//
//  Created by Julie Childress on 7/13/25.
//

import Observation

@Observable
final class LoginState {

    // MARK: Published Properties

    let fields: [LoginField]
    var usernameInput: String
    var passwordInput: String

    var isLoggingIn: Bool
    var showLoginFailedAlert: Bool

    var isSubmitButtonEnabled: Bool {
        !usernameInput.isEmpty && !passwordInput.isEmpty
    }

    // MARK: Private Properties

    private let authStore: AuthStoring

    // MARK: Initial State

    init(
        authStore: AuthStoring
    ) {
        self.fields = [.username, .password]
        self.usernameInput = ""
        self.passwordInput = ""

        self.isLoggingIn = false
        self.showLoginFailedAlert = false

        self.authStore = authStore
    }

    // MARK: Intent Handling

    func send(_ intent: LoginIntent) {
        switch intent {
        case .userSubmitted:
            attemptLogin()
        case .dismissLoginFailedAlert:
            showLoginFailedAlert = false
        }
    }

    private func attemptLogin() {
        isLoggingIn = true
        Task {
            do {
                try await authStore.login(
                    username: usernameInput,
                    password: passwordInput
                )
            } catch {
                await showLoginErrorAlert()
            }

            await updateIsLoggingIn(false)
        }
    }

    @MainActor
    private func updateIsLoggingIn(_ isLoggingIn: Bool) {
        self.isLoggingIn = isLoggingIn
    }

    @MainActor
    private func showLoginErrorAlert() {
        self.showLoginFailedAlert = true
    }
}

// MARK: LoginField

enum LoginField {
    case username
    case password

    var title: String {
        switch self {
        case .username:
            LocalizedString.Login.username
        case .password:
            LocalizedString.Login.password
        }
    }

    var placeholder: String {
        switch self {
        case .username:
            LocalizedString.Login.usernamePlaceholder
        case .password:
            LocalizedString.Login.passwordPlaceholder
        }
    }
}

// MARK: Intents

enum LoginIntent {
    case userSubmitted
    case dismissLoginFailedAlert
}
