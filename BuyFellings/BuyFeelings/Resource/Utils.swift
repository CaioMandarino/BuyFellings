//
//  Utils.swift
//  BuyFeelings
//
//  Created by Larissa Kailane on 17/10/25.
//
import SwiftUI

extension View {
    func lightShadow() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.black.opacity(0.5))
                    .shadow(radius: 4)
            )
    }
}

extension Image {
    func thumbnail() -> some View {
        self
            .resizable()
            .frame(width: 32, height: 32)
            .aspectRatio(1, contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
    
    func card() -> some View {
        self
            .resizable()
            .frame(width: 220, height: 220)
            .aspectRatio(1, contentMode: .fill)
    }
}

extension FormatStyle {
    public static func dolar<Value>() -> Self where Self == FloatingPointFormatStyle<Value>.Currency, Value : BinaryFloatingPoint {
        return .currency(code: "USD")
    }
}

