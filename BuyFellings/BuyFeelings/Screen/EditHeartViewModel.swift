//
//  EditHeartViewModel.swift
//  BuyFeelings
//
//  Created by Raquel Souza on 22/10/25.
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
final class EditHeartViewModel: ObservableObject {
    @Published var cards: [CardItem] = []
    
    private var cancellable: Set<AnyCancellable> = [] //ou vc instancia com Set<AnyCancellable>() > generics "mais swifty de acordo com o Ragel"
    private let paymentService: any StoreKitProtocol
    private let databaseService: any DatabaseProtocol
    
    init(storeKitManager: any StoreKitProtocol, databaseService: any DatabaseProtocol) {
        self.paymentService = storeKitManager
        self.databaseService = databaseService
        
        Task {
            cards = await loadProducts()

        }
    }
    
    
//    func loadView(viewModel: BuyEmotionsViewModel) -> any View {
//        EditHeartView(viewModel: viewModel, items: cards)
//    }
    
    private func loadProducts() async -> [CardItem] {
        var allCards: [CardItem] = []
        let allProducts = ProductsIdentifiers.allCases
        
        for product in allProducts  {
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
            } else if ProductsIdentifiers.feelingsToCategory(for: product) != .hearts {
                databaseService.add(element: PurchasedHearts(id: UUID(), name: product.rawValue))
            }
        }
    }
}

