//
//  CardHeartComponent.swift
//  BuyFeelings
//
//  Created by Larissa Kailane on 21/10/25.
//

import SwiftUI

struct CardHeartComponent: View {
    
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
                
                Button("Buy Heart") {
                    Task {
                        //ação da compra aqui
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
