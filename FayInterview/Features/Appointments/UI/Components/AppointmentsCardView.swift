//
//  AppointmentsCardView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import SwiftUI

struct AppointmentsCardView: View {
    private enum Constants {
        static let shadow: DesignShadow = .init(
            fillColor: DesignColor.Background.primary,
            shadowColor: .black.opacity(0.1),
            shadowRadius: 12,
            shadowPosition: .init(
                x: 0,
                y: 4
            )
        )
        static let shadowColor: Color = .black.opacity(0.1)
        static let shadowPosition: CGPoint = .init(x: 0, y: 4)
        static let shadowRadius: CGFloat = 12
    }

    let month: String
    let day: String
    let time: String
    let description: String
    let isNearestAppointment: Bool
    let onJoinAppointmentTapped: (() -> Void)?

    init(
        month: String,
        day: String,
        time: String,
        description: String,
        isNearestAppointment: Bool,
        onJoinAppointmentTapped: (() -> Void)? = nil
    ) {
        self.month = month
        self.day = day
        self.time = time
        self.description = description
        self.isNearestAppointment = isNearestAppointment
        self.onJoinAppointmentTapped = onJoinAppointmentTapped
    }

    var accessibilityLabel: String {
        var appointmentInformation: String = [
            description,
            time,
            month,
            day
        ]
            .joined(separator: ", ")
        if isNearestAppointment {
            appointmentInformation += ", \(LocalizedString.Appointments.joinButton)"
        }

        return appointmentInformation
    }

    var body: some View {
        VStack {
            HStack(spacing: DesignPadding.large) {
                calendarIconView

                descriptionView

                Spacer()
            }
            .padding(DesignPadding.large)

            if isNearestAppointment {
                joinButtonView
                    .buttonStyle(.borderless)
            }
        }
        .border(
            isNearestAppointment ? .neutralFay50Stroke : .fieldsStrokeEnabled,
            with: isNearestAppointment ? Constants.shadow : nil
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel)
    }

    private var calendarIconView: some View {
        VStack(spacing: .none) {
            Text(month)
                .font(DesignFont.captionEyebrow)
                .foregroundStyle(DesignColor.Text.primary)
                .padding(.horizontal, DesignPadding.medium)
                .background(
                    DesignColor.Calendar.headerUpcoming
                        .clipShape(
                            .rect(
                                cornerRadii: .init(
                                    topLeading: 3.6,
                                    bottomLeading: 0,
                                    bottomTrailing: 0,
                                    topTrailing: 3.6
                                )
                            )
                        )
                )

            Text(day)
                .font(DesignFont.caption)
                .foregroundStyle(DesignColor.Text.base)
                .padding(.horizontal, DesignPadding.medium)
        }
        .background {
            DesignColor.Calendar.backgroundUpcoming
                .clipShape(
                    .rect(
                        cornerRadii: .init(
                            topLeading: 0,
                            bottomLeading: 3.6,
                            bottomTrailing: 3.6,
                            topTrailing: 0
                        )
                    )
                )
        }
    }

    private var descriptionView: some View {
        VStack(
            alignment: .leading,
            spacing: DesignPadding.extraSmall
        ) {
            Text(time)
                .font(DesignFont.smallBodyBold)
                .foregroundStyle(DesignColor.Text.base)

            Text(description)
                .font(DesignFont.captionMedium)
                .foregroundStyle(DesignColor.Text.subtle)
        }
    }

    private var joinButtonView: some View {
        Button(action: { onJoinAppointmentTapped?() }) {
            HStack(spacing: .none) {
                DesignIcon.videoCamera.image
                    .foregroundStyle(DesignColor.Interactive.invertedEnabled)
                    .padding(.leading, DesignPadding.large)

                Text(LocalizedString.Appointments.joinButton)
                    .padding(.vertical, DesignPadding.large)
                    .padding(.trailing, DesignPadding.large)
            }
            .font(DesignFont.smallBodyBold)
            .foregroundColor(DesignColor.Interactive.invertedEnabled)
            .frame(maxWidth: .infinity)
            .background(
                DesignColor.Button.primaryFillEnabled
            )
            .cornerRadius(DesignPadding.medium)
            .padding(.horizontal, DesignPadding.large)
            .padding(.bottom, DesignPadding.large)
        }
    }
}

#Preview("Nearest Appointment") {
    AppointmentsCardView(
        month: "NOV",
        day: "24",
        time: "11 AM",
        description: "Follow up",
        isNearestAppointment: true,
        onJoinAppointmentTapped: { print("onJoinAppointmentTapped") }
    )
}

#Preview("Appointment") {
    AppointmentsCardView(
        month: "NOV",
        day: "24",
        time: "11 AM",
        description: "Follow up",
        isNearestAppointment: false
    )
}
