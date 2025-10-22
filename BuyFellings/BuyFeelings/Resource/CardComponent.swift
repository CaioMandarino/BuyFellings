//
//  CardComponent.swift
//  BuyFeelings
//
//  Created by Larissa Kailane on 17/10/25.
//

import SwiftUI

struct CardComponent: View {
    
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
                .tint(Color.sadness) // cor do botÃ£o

            }
            .padding()
        }
        
        .background(.background.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .lightShadow()
        .padding()
        }
    }



