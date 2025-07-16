//
//  WelcomeView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/13/25.
//

import SwiftUI

struct WelcomeView: View {

    private enum Constants {
        static let animationTime: Double = 1.5
    }

    @Binding var shouldAnimateName: Bool

    let name: String
    let onAnimationComplete: () -> Void

    var body: some View {
        HStack(spacing: DesignPadding.medium) {
            Text(LocalizedString.Welcome.title)
                .font(DesignFont.welcomeTitleThin)
                .foregroundStyle(DesignColor.Text.base)

            Text(name)
                .font(DesignFont.titleH1)
                .foregroundStyle(DesignColor.Text.primary)
                .opacity(shouldAnimateName ? 1 : 0)
                .offset(y: shouldAnimateName ? 0 : 100)
                .animation(
                    .easeInOut(duration: Constants.animationTime),
                    value: shouldAnimateName
                )

            Spacer()
        }
        .padding(.horizontal, DesignPadding.large)
        .onAppear {
            self.shouldAnimateName = true

            DispatchQueue.main.asyncAfter(
                deadline: .now() + Constants.animationTime
            ) {
                onAnimationComplete()
            }
        }
    }
}

#Preview {
    @Previewable @State var shouldAnimateName: Bool = false

    WelcomeView(
        shouldAnimateName: $shouldAnimateName,
        name: "Julie",
    ) {}
        .onAppear { shouldAnimateName = true }
}
