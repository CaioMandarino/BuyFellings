
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
    @Published var userHavePremiumSession: Bool {
        willSet {
            UserDefaults.standard.set(newValue, forKey: "userHavePremiumSession")
        }
    }
    
    private var cancellable: Set<AnyCancellable> = [] //ou vc instancia com Set<AnyCancellable>() > generics "mais swifty de acordo com o Ragel"
    private let paymentService: any StoreKitProtocol
    private let databaseService: any DatabaseProtocol
    
    init(storeKitManager: any StoreKitProtocol, databaseService: any DatabaseProtocol) {
        userHavePremiumSession = UserDefaults.standard.bool(forKey: "userHavePremiumSession")
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
            .sink { [weak self] purchasedProducts in
                guard let self else { return }
                if self.haveSubscription(for: purchasedProducts) {
                    userHavePremium = true
                } else {
                    userHavePremium = false
                }
                
            }
            .store(in: &cancellable)
    }
    
    private func haveSubscription(for purchasedProducts: Set<ProductsIdentifiers>) -> Bool {
        return purchasedProducts.contains { productsIdentifiers in
            return ProductsIdentifiers.feelingsToCategory(for: productsIdentifiers) == .subscription
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
            } else if ProductsIdentifiers.feelingsToCategory(for: product) != .subscription {
                databaseService.add(element: PurchasedFeelingsModel(id: UUID(), name: product.rawValue, duration: 60))
            } else if product == .season {
                userHavePremiumSession = true
            }
        }
    }
}

