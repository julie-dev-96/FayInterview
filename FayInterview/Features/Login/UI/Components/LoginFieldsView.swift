//
//  LoginFieldsView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/13/25.
//

import SwiftUI

struct LoginFieldsView: View {
    let fields: [LoginField]
    @Binding var usernameInput: String
    @Binding var passwordInput: String

    var body: some View {
        HStack {
            Text(LocalizedString.Login.login)
                .font(DesignFont.titleH1)
                .foregroundStyle(DesignColor.Text.base)

            Spacer()
        }
        .padding(DesignPadding.large)

        ForEach(fields, id: \.self) { field in
            switch field {
            case .username:
                LoginTextFieldView(
                    field: .username,
                    response: $usernameInput
                )
            case .password:
                LoginTextFieldView(
                    field: .password,
                    response: $passwordInput
                )
            }
        }
        .padding(.vertical, DesignPadding.small)
    }
}

#Preview {
    @Previewable @State var usernameInput = ""
    @Previewable @State var passwordInput = ""

    LoginFieldsView(
        fields: [.username, .password],
        usernameInput: $usernameInput,
        passwordInput: $passwordInput
    )
}
