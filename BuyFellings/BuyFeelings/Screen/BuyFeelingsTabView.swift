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
    let storeViewModel: BuyEmotionsViewModel

    var body: some View {
        TabView {
            Tab("Home", systemImage: "heart.fill") {
                HomeView(viewModel: homeViewModel)
            }
            
            Tab("Buy", systemImage: "heart.fill") {
                BuyEmotionsView(viewModel: storeViewModel)
            }
            
            Tab("Active", systemImage: "heart.fill") {
                ActiveFeelingTest(databaseManager: contentViewModel.databaseService)
            }
        }
    }
}
