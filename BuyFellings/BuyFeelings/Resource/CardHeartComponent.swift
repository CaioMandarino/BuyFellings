//
//  CardHeartComponent.swift
//  BuyFeelings
//
//  Created by Larissa Kailane on 21/10/25.
//

import SwiftUI

struct CardHeartComponent: View {
    
    @ObservedObject var viewModel: EditHeartViewModel
    let item: CardItem
    
    var body: some View {
        VStack(spacing: .zero) {
            
            Image(item.image)
                .resizable()
                .frame(width: 120, height: 100)
                .aspectRatio(contentMode: .fit)
                
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.price)
                        .font(.footnote)
                }
                
                Spacer()
                
                Button("Buy Heart") {
                    Task {
                        await viewModel.purchase(product: item.productID)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.sadness) // cor do botão

            }
            .padding()
        }
        .background(.background.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .lightShadow()
        .padding()
    }
}
