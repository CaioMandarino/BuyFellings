//
//  Digit.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 19/10/25.
//

import SwiftUI

struct DigitModifier: ViewModifier {
    let font: Font
    let value: Double
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(.semibold)
            .frame(maxHeight: 40)
            .monospaced()
            .contentTransition(.numericText(value: value))
            .transaction { transaction in
                transaction.animation = .easeOut(duration: 0.8)
            }
            .padding()
    }
}

extension View {
    public func digitStyle(font: Font, value: Int) -> some View {
        modifier(DigitModifier(font: font, value: Double(value)))
    }
}
