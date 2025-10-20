//
//  BreathingPulseModifier.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 19/10/25.
//

import SwiftUI

struct BreathingPulseModifier: ViewModifier {
    var minScale: CGFloat = 0.94
    var maxScale: CGFloat = 1.06
    var duration: Double = 1.1

    @State private var isPulsing = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? maxScale : minScale)
            .animation(
                .bouncy(duration: duration).repeatForever(autoreverses: true),
                value: isPulsing
            )
            .onAppear { isPulsing = true }
    }
}

extension View {
    func breathingPulse() -> some View {
        modifier(BreathingPulseModifier())
    }
}
