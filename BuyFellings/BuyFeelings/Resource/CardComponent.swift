//
//  CardComponent.swift
//  BuyFeelings
//
//  Created by Larissa Kailane on 17/10/25.
//

import SwiftUI

struct CardComponent: View {
    
    let item: CardItem
    
    var body: some View {
        VStack(spacing: .zero) {
            
            Image(item.image)
                .card()
                
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.price, format: .dolar())
                        .font(.footnote)
                }
                
                Spacer()
                
                Button("Buy emotion") {
//                    buyEmotion()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        
        .background(.background.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .lightShadow()
            .padding()
        }
    }

#Preview {
    @Previewable @State var isFavorite = false
    
    CardComponent(
        item: .init(
            id: "com.CaioMandarino.BuyFellings.bad.anxiety",
            name: "Criativity",
            price: 0.99,
            image: "Criativity"
        )
    )
    .padding()
    .background(.background.secondary)
}
