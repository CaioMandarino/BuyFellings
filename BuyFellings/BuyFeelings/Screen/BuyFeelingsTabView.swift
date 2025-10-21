//
//  BuyFeelingsTabView.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 17/10/25.
//

import SwiftUI

struct BuyFeelingsTabView: View {
    let homeViewModel: HomeViewModel
    let buyEmotionsViewModel: BuyEmotionsViewModel
//    let contentViewModel: ContentViewModel
    let feelingScreenViewModel: FeelingScreenViewModel

    var body: some View {
        TabView {
            Tab("Home", systemImage: "heart.fill") {
                HomeView(viewModel: homeViewModel)
            }
            
            Tab("Buy", systemImage: "heart.fill") {
                BuyEmotionsView(viewModel: buyEmotionsViewModel)
//                ContentView(viewModel: contentViewModel)
            }
            
            Tab("Active", systemImage: "heart.fill") {
                FeelingActivateScreen(viewModel: feelingScreenViewModel)
            }
        }
    }
}
