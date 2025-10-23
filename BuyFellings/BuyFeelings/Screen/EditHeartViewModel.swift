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

import SwiftUI
import Combine
import StoreKit

@MainActor
final class EditHeartViewModel: ObservableObject {
    @Published var cards: [CardItem] = []
    
    // IDs dos corações comprados
    @Published private(set) var purchasedHearts: Set<String> = []
    // ID do coração ativo
    @Published private(set) var activeHeartID: String?
    // Nome do coração ativo
    @Published private(set) var activeHeartName: String?

    private var cancellable: Set<AnyCancellable> = []
    private let paymentService: any StoreKitProtocol
    private let databaseService: any DatabaseProtocol
    
    init(storeKitManager: any StoreKitProtocol, databaseService: any DatabaseProtocol) {
        self.paymentService = storeKitManager
        self.databaseService = databaseService
        
        Task {
            cards = await loadProducts()
            observePurchasedHearts()
        }
    }
    
    // MARK: - Carrega produtos
    private func loadProducts() async -> [CardItem] {
        var allCards: [CardItem] = []
        for product in ProductsIdentifiers.allCases {
            let card = CardItem(
                name: ProductsIdentifiers.feelingsToString(feeling: product),
                price: (try? await paymentService.price(product: product)) ?? "N/A",
                image: ProductsIdentifiers.feelingsToImage(feeling: product),
                category: ProductsIdentifiers.feelingsToCategory(for: product),
                productID: product
            )
            allCards.append(card)
        }
        return allCards
    }
    
    // MARK: - Observa compras (igual das assinaturas)
    private func observePurchasedHearts() {
        Task {
            await paymentService.publisherPurchaseProducts
                .receive(on: DispatchQueue.main)
                .sink { [weak self] purchasedProducts in
                    guard let self else { return }
                    
                    // Filtra apenas os corações
                    let hearts = purchasedProducts.filter { product in
                        ProductsIdentifiers.feelingsToCategory(for: product) == .hearts
                    }
                    
                    // Atualiza lista de IDs comprados
                    purchasedHearts = Set(hearts.map { $0.rawValue })
                    
                    // Atualiza coração ativo do banco
                    if let active = databaseService.getAllElements().first(where: { (element: PurchasedHearts) in element.isActive }) {
                        activeHeartID = active.name
                        activeHeartName = cards.first(where: { $0.productID.rawValue == active.name })?.name
                    } else {
                        activeHeartID = nil
                        activeHeartName = nil
                    }

                }
                .store(in: &cancellable)
        }
    }
    
    // MARK: - Verificações para a UI
    func isPurchased(_ item: CardItem) -> Bool {
        purchasedHearts.contains(item.productID.rawValue)
    }
    
    func isActive(_ item: CardItem) -> Bool {
        activeHeartID == item.productID.rawValue
    }
    
    // MARK: - Ativar coração
    func activateHeart(_ item: CardItem) {
        var hearts: [PurchasedHearts] = databaseService.getAllElements()
        for i in hearts.indices {
            hearts[i].isActive = (hearts[i].name == item.productID.rawValue)
            databaseService.update(element: hearts[i])
        }
        // Atualiza estado ativo
        activeHeartID = item.productID.rawValue
        activeHeartName = item.name
    }

    // MARK: - Comprar coração
    func purchase(product: ProductsIdentifiers) async {
        guard let status = try? await paymentService.purchase(product: product), status == .success else { return }
        
        if ProductsIdentifiers.feelingsToCategory(for: product) == .hearts {
            // Salva no banco se ainda não existe
            let hearts: [PurchasedHearts] = databaseService.getAllElements()
            if hearts.first(where: { (heart: PurchasedHearts) in heart.name == product.rawValue }) == nil {
                databaseService.add(element: PurchasedHearts(id: UUID(), name: product.rawValue))
            }
        } else {
            // Outros produtos (ex.: duração)
            let allEntities: [PurchasedFeelingsModel] = databaseService.getAllElements()
            if let element = allEntities.first(where: { (item: PurchasedFeelingsModel) in item.name == product.rawValue }) {
                element.duration += 60
                databaseService.update(element: element)
            } else {
                databaseService.add(element: PurchasedFeelingsModel(id: UUID(), name: product.rawValue, duration: 60))
            }
        }

        
        // Atualiza UI via publisher
        observePurchasedHearts()
    }
}
