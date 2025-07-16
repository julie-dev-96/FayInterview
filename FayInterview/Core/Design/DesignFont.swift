//
//  DesignFont.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import SwiftUI

public enum DesignFont {
    static let captionEyebrow: Font = .custom(
        FontName.manropeSemiBold.rawValue,
        size: 12
    )

    static let captionMedium: Font = .custom(
        FontName.manropeMedium.rawValue,
        size: 12
    )

    static let caption: Font = .custom(
        FontName.manropeSemiBold.rawValue,
        size: 18
    )

    static let tabTitle: Font = .custom(
        FontName.manropeSemiBold.rawValue,
        size: 10
    )

    static let tabSelectedTitle: Font = .custom(
        FontName.manropeExtraBold.rawValue,
        size: 10
    )

    static let titleH1: Font = .custom(
        FontName.manropeExtraBold.rawValue,
        size: 24
    )

    static let smallBodyBold: Font = .custom(
        FontName.manropeBold.rawValue,
        size: 14
    )

    static let subtle: Font = .custom(
        FontName.manropeBold.rawValue,
        size: 14
    )

    static let welcomeTitleThin: Font = .custom(
        FontName.manropeLight.rawValue,
        size: 24
    )

    private enum FontName: String {
        case manropeBold = "Manrope-Bold"
        case manropeExtraBold = "Manrope-ExtraBold"
        case manropeLight = "Manrope-Light"
        case manropeMedium = "Manrope-Medium"
        case manropeSemiBold = "Manrope-SemiBold"
    }
}
