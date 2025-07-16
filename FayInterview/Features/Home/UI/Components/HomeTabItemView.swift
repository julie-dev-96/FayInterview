//
//  HomeTabItemView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/12/25.
//

import SwiftUI

struct HomeTabItemView: View {
    let tab: HomeTab
    let tabItem: HomeTab.Item

    var body: some View {
        VStack {
            tabItem.designIcon(for: tab).image

            Text(tabItem.name)
        }
        .font(
            tabItem.isSelected ? DesignFont.tabSelectedTitle : DesignFont.tabTitle
        )
        .foregroundStyle(
            tabItem.isSelected ? DesignColor.Interactive.primaryEnabled : DesignColor.Interactive.neutralEnabled
        )
    }
}

#Preview("Appointments Tab") {
    HomeTabItemView(
        tab: .appointments,
        tabItem: HomeTab.appointments.item(
            isSelected: true
        )
    )
}

#Preview("Chat Tab") {
    HomeTabItemView(
        tab: .chat,
        tabItem: HomeTab.chat.item(
            isSelected: false
        )
    )
}

#Preview("Journal Tab") {
    HomeTabItemView(
        tab: .journal,
        tabItem: HomeTab.journal.item(
            isSelected: false
        )
    )
}

#Preview("Profile Tab") {
    HomeTabItemView(
        tab: .profile,
        tabItem: HomeTab.profile.item(
            isSelected: false
        )
    )
}
