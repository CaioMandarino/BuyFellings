
//  StoreViewModel.swift
//  BuyFeelings
//
//  Created by Raquel Souza on 20/10/25.
//

import StoreKit
import SwiftUI
import Combine


@MainActor
final class BuyEmotionsViewModel: ObservableObject {
    @Published var cards: [CardItem] = []
    @Published var userHavePremium: Bool = false
    @Published var userHaveSeason: Bool = false
    
    private var cancellable: Set<AnyCancellable> = [] //ou vc instancia com Set<AnyCancellable>() > generics "mais swifty de acordo com o Ragel"
    private let paymentService: any StoreKitProtocol
    private let databaseService: any DatabaseProtocol
    
    init(storeKitManager: any StoreKitProtocol, databaseService: any DatabaseProtocol) {
        self.paymentService = storeKitManager
        self.databaseService = databaseService
        
        Task {
            cards = await loadProducts()
            await observeSubscription()
        }
    }
    
    private func observeSubscription() async {
        await paymentService.publisherPurchaseProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] purchedProducts in
                guard let self else { return }
                
                //Premium
                if self.haveSubscripiton(for: purchedProducts) {
                    userHavePremium = true
                } else {
                    userHavePremium = false
                }
                
                //Season
                if self.haveSeason(for: purchedProducts) {
                    userHaveSeason = true
                } else {
                    userHaveSeason = false
                }
                
            }
            .store(in: &cancellable)
    }
    
    private func haveSubscripiton(for purchedProducts: Set<ProductsIdentifiers>) -> Bool {
        return purchedProducts.contains { productsIdentifiers in
            return ProductsIdentifiers.feelingsToCategory(for: productsIdentifiers) == .subscription
        }
    }
    
    private func haveSeason(for purchedProducts: Set<ProductsIdentifiers>) -> Bool {
        return purchedProducts.contains { productsIdentifiers in
            return ProductsIdentifiers.feelingsToCategory(for: productsIdentifiers) == .seasonPass
        }
    }
    
    private func loadProducts() async -> [CardItem] {
        var allCards: [CardItem] = []
        let allProducts = ProductsIdentifiers.allCases
        
        for product in allProducts {
            let name = ProductsIdentifiers.feelingsToString(feeling: product)
            let image = ProductsIdentifiers.feelingsToImage(feeling: product)
            let price = try? await paymentService.price(product: product)
            let category = ProductsIdentifiers.feelingsToCategory(for: product)
            
            let cardItem = CardItem(
                name: name,
                price: price ?? "N/A",
                image: image,
                category: category,
                productID: product
            )
            
            allCards.append(cardItem)
        }
        
        return allCards
    }
    
    func purchase(product: ProductsIdentifiers) async {
        let status = try? await paymentService.purchase(product: product)
        
        let allEntities: [PurchasedFeelingsModel] = databaseService.getAllElements()
        
        if status == .success {
            if let element = allEntities.first(where: { $0.name == product.rawValue }) {
                element.duration += 60
                databaseService.update(element: element)
            } else {
                databaseService.add(element: PurchasedFeelingsModel(id: UUID(), name: product.rawValue, duration: 60))
            }
        }
    }
}

