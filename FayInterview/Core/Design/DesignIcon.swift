//
//  DesignIcon.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import SwiftUI

public enum DesignIcon: String {
    case addAppointment = "AddAppointment"
    case calendar = "Calendar"
    case calendarFilled = "CalendarFilled"
    case chats = "Chats"
    case notebookText = "NotebookText"
    case user = "User"
    case videoCamera = "VideoCamera"

    var image: Image {
        Image(rawValue)
    }
}
