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
                
                if viewModel.isPurchased(item) {
                       if viewModel.isActive(item) {
                           // Coração já ativo
                           Text("Active")
                               .font(.subheadline)
                               .foregroundStyle(.green)
                       } else {
                           // Coração comprado, mas não ativo
                           Button("Activate") {
                               viewModel.activateHeart(item)
                           }
                           .buttonStyle(.borderedProminent)
                           .tint(.pink)
                       }
                   } else {
                       // Coração não comprado
                       Button("Buy Heart") {
                           Task {
                               await viewModel.purchase(product: item.productID)
                           }
                       }
                       .buttonStyle(.borderedProminent)
                       .tint(Color.sadness)
                   }
               }
            .padding()
        }
        .background(.background.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .lightShadow()
        .padding()
    }
}
