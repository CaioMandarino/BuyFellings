//
//  StoreViewModel.swift
//  BuyFeelings
//
//  Created by Raquel Souza on 20/10/25.
//

import StoreKit
import SwiftUI
import Combine

@MainActor
class BuyEmotionsViewModel: ObservableObject {
    @Published var cards: [CardItem] = []
    
    private let manager: any StoreKitProtocol
    
    init(storeKitManager: any StoreKitProtocol) {
        manager = storeKitManager
        
        Task {
            cards = await loadProducts()
        }
    }
    
    func loadProducts() async -> [CardItem] {
        var allCards: [CardItem] = []
        let allProducts = ProductsIdentifiers.allCases
        
        for product in allProducts {
            let name = ProductsIdentifiers.feelingsToString(feeling: product)
            let image = ProductsIdentifiers.feelingsToImage(feeling: product)
            let price = try? await manager.price(product: product)
            let category = ProductsIdentifiers.feelingsToCategory(for: product)
            
            let cardItem = CardItem(
                name: name,
                price: price ?? "N/A",
                image: image,
                category: category
            )
            
            allCards.append(cardItem)
        }
        
        return allCards
    }
}

