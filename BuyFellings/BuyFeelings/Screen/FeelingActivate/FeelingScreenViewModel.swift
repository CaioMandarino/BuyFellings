//
//  FeelingScreenViewModel.swift
//  BuyFeelings
//
//  Created by israel lacerda gomes santos on 20/10/25.
//
import Foundation
import Observation
import Combine

@Observable
@MainActor
final class FeelingScreenViewModel {
    // variables
    var feelingModels: [FeelingActivateModel] = []
    var subscriptions: [SubscriptionModel] = [] // isso aqui tem vir do database tbm
    
    private let databaseManager: any DatabaseProtocol
    private let paymentService: any StoreKitProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(databaseManager: any DatabaseProtocol, paymentService: any StoreKitProtocol) {
        self.paymentService = paymentService
        self.databaseManager = databaseManager
        getModels(databaseManager: databaseManager)
        observableDataBase()
        Task {
            await getSubscriptions()
        }
    }
    
    private func getSubscriptions() async {
        await paymentService.publisherPurchaseProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                guard let self else { return }
                
                var newElements: [SubscriptionModel] = []
                
                for product in products {
                    if ProductsIdentifiers.feelingsToCategory(for: product) != .subscription { continue }
                    let name = ProductsIdentifiers.feelingsToString(feeling: product)
                    
                    newElements.append(SubscriptionModel(title: name))
                }
                
                subscriptions = newElements
                
            }
            .store(in: &cancellables)
    }
    
    
    
    func observableDataBase() {
        databaseManager.databaseChangePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                getModels(databaseManager: self.databaseManager)
            }
            .store(in: &cancellables)
    }
    
    func getModels (databaseManager: any DatabaseProtocol) {
        var allPurchased: [FeelingActivateModel] = []
        let purchaseFeelings: [PurchasedFeelingsModel] = databaseManager.getAllElements()
        for purchaseFeeling in purchaseFeelings {
            guard let feeling = ProductsIdentifiers(rawValue: purchaseFeeling.name) else { continue }
            let item = FeelingActivateModel(feeling: feeling, timeInSeconds: "") {
                purchaseFeeling.isActive = true
                databaseManager.update(element: purchaseFeeling)
            }
            allPurchased.append(item)
        }
        
        feelingModels = allPurchased
    }
}
