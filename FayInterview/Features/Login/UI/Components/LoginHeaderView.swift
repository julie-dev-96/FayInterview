//
//  LoginHeaderView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/13/25.
//

import SwiftUI

struct LoginHeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "sun.horizon")
                .foregroundStyle(DesignColor.Text.primary)

            Text("Fay")
                .foregroundStyle(DesignColor.Text.base)

            Spacer()
        }
        .font(DesignFont.titleH1)
        .padding(.horizontal, DesignPadding.large)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Fay")
    }
}

#Preview {
    LoginHeaderView()
}
