//
//  LoginTextFieldView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/13/25.
//

import SwiftUI

struct LoginTextFieldView: View {
    let field: LoginField
    @Binding var response: String

    var body: some View {
        VStack(alignment: .leading, spacing: DesignPadding.medium) {
            Text(field.title)
                .font(DesignFont.captionEyebrow)

            Group {
                switch field {
                case .username:
                    TextField(
                        field.placeholder,
                        text: $response,
                    )
                case .password:
                    SecureField(
                        field.placeholder,
                        text: $response
                    )
                }
            }
            .font(DesignFont.caption)
            .padding(DesignPadding.large)
            .border(.fieldsStrokeEnabled)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
        }
        .foregroundStyle(DesignColor.Text.base)
        .padding(.horizontal, DesignPadding.large)
    }
}

#Preview("Username") {
    @Previewable @State var response: String = ""

    LoginTextFieldView(
        field: .username,
        response: $response
    )
}

#Preview("Password") {
    @Previewable @State var response: String = ""

    LoginTextFieldView(
        field: .password,
        response: $response
    )
}
