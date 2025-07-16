//
//  AppointmentsTabView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import SwiftUI

struct AppointmentsTabView: View {
    @Binding var selectedTab: AppointmentTab
    let onUpcomingTabSelected: () -> Void
    let onPastTabSelected: () -> Void

    init(
        selectedTab: Binding<AppointmentTab>,
        onUpcomingTabSelected: @escaping () -> Void,
        onPastTabSelected: @escaping () -> Void
    ) {
        self._selectedTab = selectedTab
        self.onUpcomingTabSelected = onUpcomingTabSelected
        self.onPastTabSelected = onPastTabSelected
    }

    var body: some View {
        VStack(spacing: .none) {
            HStack(spacing: .none) {
                TabItem(
                    isSelected: selectedTab == .upcoming,
                    title: LocalizedString.Appointments.upcomingTab
                ) {
                    onUpcomingTabSelected()
                }

                TabItem(
                    isSelected: selectedTab == .past,
                    title: LocalizedString.Appointments.pastTab,
                ) {
                    onPastTabSelected()
                }
            }

            ZStack {
                HorizontalSeparatorView()

                GeometryReader { proxy in
                    let tabWidth = proxy.size.width / 2
                    Rectangle()
                        .frame(width: tabWidth, height: 1)
                        .foregroundStyle(DesignColor.Interactive.primaryEnabled)
                        .offset(x: selectedTab == .past ? tabWidth : 0)
                        .animation(.easeInOut(duration: 0.25), value: selectedTab)
                }
                .frame(height: 1)
            }
        }
    }
}

private struct TabItem: View {
    private let isSelected: Bool
    private let title: String
    private let onTap: () -> Void

    init(
        isSelected: Bool,
        title: String,
        onTap: @escaping () -> Void
    ) {
        self.isSelected = isSelected
        self.title = title
        self.onTap = onTap
    }

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(DesignFont.subtle)
                .foregroundStyle(
                    isSelected ?
                    DesignColor.Interactive.primaryEnabled :
                    DesignColor.Text.subtle
                )
                .padding(.vertical, DesignPadding.medium)
                .padding(.horizontal, DesignPadding.extraLarge)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    @Previewable @State var selectedTab: AppointmentTab = .upcoming
    ZStack {
        AppointmentsTabView(
            selectedTab: $selectedTab,
            onUpcomingTabSelected: { selectedTab = .upcoming },
            onPastTabSelected: { selectedTab = .past }
        )
    }
}
