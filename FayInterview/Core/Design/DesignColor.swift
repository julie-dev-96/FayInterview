//
//  DesignColor.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import SwiftUI

public enum DesignColor {
    public enum Background {
        static let primary: Color = .backgroundPrimary
    }

    public enum Button {
        static let primaryFillDisabled: Color = .purpleDisabled
        static let primaryFillEnabled: Color = .purplePrimary
        static let defaultFillEnabled: Color = .whitePrimary
        static let defaultStrokeEnabled: Color = .strokePrimary
    }

    public enum Calendar {
        static let backgroundUpcoming: Color = .whiteSecondary
        static let headerUpcoming: Color = .purpleSecondary
    }

    public enum Divider {
        static let primary: Color = .strokePrimary
    }

    public enum Fields {
        static let strokeEnabled: Color = .strokePrimary
    }

    public enum Interactive {
        static let invertedEnabled: Color = .backgroundPrimary
        static let neutralEnabled: Color = .grayPrimary
        static let primaryEnabled: Color = .purplePrimary
    }

    public enum LoadingSpinner {
        static let primary: Color = .purplePrimary
    }

    public enum Neutral {
        static let fay50: Color = .whiteSecondary
    }

    public enum Text {
        static let base: Color = .grayPrimary
        static let primary: Color = .purplePrimary
        static let subtle: Color = .textSubtle
    }
}
