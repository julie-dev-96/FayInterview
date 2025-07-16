//
//  DesignBorder.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import Foundation
import SwiftUI

public enum DesignBorder {
    case buttonDefaultStrokeEnabled
    case fieldsStrokeEnabled
    case neutralFay50Stroke

    var cornerRadius: CGSize {
        switch self {
        case .buttonDefaultStrokeEnabled:
                .init(width: 8, height: 8)
        case .fieldsStrokeEnabled,
                .neutralFay50Stroke:
                .init(width: 16, height: 16)
        }
    }

    var color: Color {
        switch self {
        case .buttonDefaultStrokeEnabled:
            DesignColor.Button.defaultStrokeEnabled
        case .fieldsStrokeEnabled:
            DesignColor.Fields.strokeEnabled
        case .neutralFay50Stroke:
            DesignColor.Neutral.fay50
        }
    }

    var width: CGFloat {
        switch self {
        case .buttonDefaultStrokeEnabled:
            0.75
        case .fieldsStrokeEnabled,
                .neutralFay50Stroke:
            1
        }
    }
}

extension View {
    @ViewBuilder
    public func border(
        _ style: DesignBorder,
        with shadow: DesignShadow? = nil
    ) -> some View {
        if let shadow {
            self.apply(borderStyle: style, shadow: shadow)
        } else {
            self.apply(borderStyle: style)
        }
    }

    private func apply(borderStyle: DesignBorder) -> some View {
        self
            .background(RoundedRectangle(
                cornerSize: borderStyle.cornerRadius
            )
            .stroke(
                borderStyle.color,
                lineWidth: borderStyle.width
            ))
    }

    private func apply(borderStyle: DesignBorder, shadow: DesignShadow) -> some View {
        self
            .background(RoundedRectangle(
                cornerSize: borderStyle.cornerRadius
            )
            .fill(shadow.fillColor)
            .shadow(
                color: shadow.shadowColor,
                radius: shadow.shadowRadius,
                x: shadow.shadowPosition.x,
                y: shadow.shadowPosition.y
            )
            .overlay(
                RoundedRectangle(cornerSize: borderStyle.cornerRadius)
                    .stroke(borderStyle.color, lineWidth: borderStyle.width)
            ))
    }
}
