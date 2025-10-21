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
    private var cancellables: Set<AnyCancellable> = []
    
    init(databaseManager: any DatabaseProtocol) {
        self.databaseManager = databaseManager
        getModels(databaseManager: databaseManager)
        observableDataBase()
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
//            print(feeling)
            let item = FeelingActivateModel(feeling: feeling, image: "", timeInSeconds: "") {
                purchaseFeeling.isActive = true
                databaseManager.update(element: purchaseFeeling)
            }
            allPurchased.append(item)
        }
        allPurchased.sort { $0.feeling.rawValue < $1.feeling.rawValue } // para resolver a questão da atualizacão depois do click
        feelingModels = allPurchased 
    }
}
