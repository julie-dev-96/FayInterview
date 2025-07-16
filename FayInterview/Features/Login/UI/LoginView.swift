//
//  LoginView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/13/25.
//

import SwiftUI

struct LoginView: View {
    @State private var state: LoginState
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    init(authStore: AuthStore) {
        self.state = LoginState(
            authStore: authStore
        )
    }

    var body: some View {
        VStack {
            LoginHeaderView()

            ScrollView(
                dynamicTypeSize.isAccessibilitySize ? .vertical : []
            ) {
                LoginFieldsView(
                    fields: state.fields,
                    usernameInput: $state.usernameInput,
                    passwordInput: $state.passwordInput
                )
            }
            .scrollDismissesKeyboard(.automatic)

            Spacer()

            LoginSubmitView(
                isEnabled: state.isSubmitButtonEnabled,
                isLoading: state.isLoggingIn
            ) {
                state.send(.userSubmitted)
            }
        }
        .simultaneousGesture(
            TapGesture().onEnded {
                hideKeyboard()
            }
        )
        .alert(
            LocalizedString.Login.Alert.invalidCredentialsTitle,
            isPresented: $state.showLoginFailedAlert,
            actions: {
                Button(
                    LocalizedString.Common.ok,
                    role: .cancel
                ) {
                    state.send(.dismissLoginFailedAlert)
                }
            },
            message: {
                Text(LocalizedString.Login.Alert.invalidCredentialsMessage)
            }
        )
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}

#Preview {
    let authStore: AuthStore = .init(
        authStatus: .needsAuth
    )
    LoginView(
        authStore: authStore
    )
}
