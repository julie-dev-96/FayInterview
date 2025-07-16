//
//  LoadingSpinnerView.swift
//  FayInterview
//
//  Created by Julie Childress on 7/10/25.
//

import SwiftUI

struct LoadingSpinnerView: View {
    @State private var isAnimating: Bool = false

    private enum Constants {
        static let lineWidth: CGFloat = 4
        static let rotationSpeed: Double = 1.0
    }

    var body: some View {
        GeometryReader { proxy in
            let spinnerSize: CGFloat = min(proxy.size.width, proxy.size.height) / 5
            let spinnerPosition: CGPoint = .init(
                x: proxy.size.width / 2,
                y: proxy.size.height / 2
            )
            Circle()
                .trim(from: 0.2, to: 1)
                .stroke(
                    DesignColor.LoadingSpinner.primary,
                    style: StrokeStyle(
                        lineWidth: Constants.lineWidth,
                        lineCap: .round
                    )
                )
                .frame(
                    width: spinnerSize,
                    height: spinnerSize
                )
                .position(spinnerPosition)
                .rotationEffect(
                    .degrees(isAnimating ? 360 : 0)
                )
                .animation(
                    .linear(
                        duration: Constants.rotationSpeed
                    )
                    .repeatForever(
                        autoreverses: false
                    ),
                    value: isAnimating
                )
                .onAppear {
                    isAnimating = true
                }
        }
    }
}

#Preview {
    LoadingSpinnerView()
}
