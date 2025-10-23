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
    let viewModelHeart: EditHeartViewModel
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "heart.fill") {
//                EditHeartView(viewModel: homeViewModel.createEditHeartViewModel())
                HomeView(viewModel: homeViewModel, viewModelHeart: viewModelHeart)
            }
            
            Tab("Buy", systemImage: "bag.fill") {
//                EditHeartView(viewModel: buyEmotionsViewModel, items: items)
                BuyEmotionsView(viewModel: buyEmotionsViewModel)
//                ContentView(viewModel: contentViewModel)
            }
            
            Tab("Active", systemImage: "play.circle.fill") {
                FeelingActivateScreen(viewModel: feelingScreenViewModel)
            }
        }
    }
}
