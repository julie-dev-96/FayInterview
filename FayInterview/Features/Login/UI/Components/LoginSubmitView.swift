//
//  LoginSubmitView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/13/25.
//

import SwiftUI

struct LoginSubmitView: View {
    let isEnabled: Bool
    let isLoading: Bool
    let onSubmit: () -> Void

    init(
        isEnabled: Bool,
        isLoading: Bool,
        onSubmit: @escaping () -> Void
    ) {
        self.isEnabled = isEnabled
        self.isLoading = isLoading
        self.onSubmit = onSubmit
    }

    var body: some View {
        Button(action: onSubmit) {
            Text(LocalizedString.Common.continue)
                .opacity(isLoading ? 0 : 1)
                .overlay {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(
                                DesignColor.Interactive.invertedEnabled
                            )
                    }
                }
            .padding(DesignPadding.large)
            .font(DesignFont.smallBodyBold)
            .foregroundColor(DesignColor.Interactive.invertedEnabled)
            .frame(maxWidth: .infinity)
            .background(
                isEnabled ?
                DesignColor.Button.primaryFillEnabled :
                DesignColor.Button.primaryFillDisabled
            )
            .cornerRadius(DesignPadding.medium)
            .padding(.horizontal, DesignPadding.large)
            .padding(.bottom, DesignPadding.large)
        }
        .disabled(!isEnabled)
    }
}

#Preview("Enabled") {
    LoginSubmitView(
        isEnabled: true,
        isLoading: false
    ) {}
}

#Preview("Disabled") {
    LoginSubmitView(
        isEnabled: false,
        isLoading: false
    ) {}
}

#Preview("Loading") {
    LoginSubmitView(
        isEnabled: true,
        isLoading: true
    ) {}
}
