//
//  BuyFeelingsTabView.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 17/10/25.
//

import SwiftUI

struct BuyFeelingsTabView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "heart.fill") {
                HomeView()
            }
            
            Tab("Buy", systemImage: "heart.fill") {
                
            }
            
            Tab("Active", systemImage: "heart.fill") {
                
            }
        }
    }
}

#Preview {
    BuyFeelingsTabView()
}
