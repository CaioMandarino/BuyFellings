//
//  ContentView.swift
//  BuyFellings
//
//  Created by Caio Mandarino on 15/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            Text("Fun duration: \(viewModel.duration)")
            
            Button ("Buy Fun duration") {
                Task {
                    await viewModel.purchase()
                }
            }
            
            Divider()
                .padding(.vertical)

            BuyEmotionsView(
                title: "Bad Feelings",
                items: [
                    .init(id: "com.CaioMandarino.BuyFellings.bad.anxiety", name: "Anxiety", price: 0.99, image: "Anxiety"),
                    .init(id: "com.CaioMandarino.BuyFellings.good.happiness", name: "Happiness", price: 1.99, image: "Happiness"),
                    .init(id: "com.CaioMandarino.BuyFellings.good.calm", name: "Companionship", price: 0.49, image: "Calm")
                ]
            )
            .frame(maxWidth: .infinity)
            
        }
        .padding()
    }
}

