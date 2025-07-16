//
//  AppointmentsHeaderView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import SwiftUI

struct AppointmentsHeaderView: View {
    let onAddButtonPressed: () -> Void

    var body: some View {
        HStack {
            Text(LocalizedString.Appointments.header)
                .font(DesignFont.titleH1)
                .foregroundStyle(DesignColor.Text.base)
                // Prevents truncation for accessibility
                .fixedSize(horizontal: false, vertical: true)

            Spacer()

            addAppointmentButton
        }
        .padding(.vertical, DesignPadding.medium)
        .padding(.horizontal, DesignPadding.extraLarge)
    }

    private var addAppointmentButton: some View {
        Button(action: onAddButtonPressed) {
            HStack {
                DesignIcon.addAppointment.image

                Text(LocalizedString.Appointments.buttonHeader)
            }
            .font(DesignFont.smallBodyBold)
            .foregroundStyle(DesignColor.Interactive.neutralEnabled)
            .padding(.vertical, DesignPadding.small)
            .padding(.horizontal, DesignPadding.medium)
            .border(.buttonDefaultStrokeEnabled)
        }
    }
}

#Preview {
    AppointmentsHeaderView(
        onAddButtonPressed: { print("Add Button Pressed") }
    )
}
