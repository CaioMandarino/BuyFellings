//
//  BuyFeelingsTabView.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 17/10/25.
//

import SwiftUI

struct BuyFeelingsTabView: View {
    let homeViewModel: HomeViewModel
    let contentViewModel: ContentViewModel
    let FeelingScreenViewModel: FeelingScreenViewModel

    var body: some View {
        TabView {
            Tab("Home", systemImage: "heart.fill") {
                HomeView(viewModel: homeViewModel)
            }
            
            Tab("Buy", systemImage: "heart.fill") {
                ContentView(viewModel: contentViewModel)
            }
            
            Tab("Active", systemImage: "heart.fill") {
                FeelingActivateScreen(viewmodel: FeelingScreenViewModel)
            }
        }
    }
}
