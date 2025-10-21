//
//  CardComponentLocked.swift
//  BuyFeelings
//
//  Created by Raquel Souza on 21/10/25.
//

import SwiftUI

struct CardComponentLocked: View {
    
    @ObservedObject var viewModel: BuyEmotionsViewModel
    
    let item: CardItem
    
    var body: some View {
        VStack(spacing: .zero) {
            
            Image(item.image)
                .card()
                
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.price)
                        .font(.footnote)
                }
                
                Spacer()
                
                Button("Buy emotion") {
                    Task {
                       await viewModel.purchase(product: item.productID)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .overlay(Color.black.opacity(0.5)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        )
        .overlay(
            Image(systemName: "lock.fill")
                .font(.largeTitle)
                .foregroundColor(.white.opacity(0.8))
        )
        .background(.background.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .lightShadow()
        .padding()
        }
    }

