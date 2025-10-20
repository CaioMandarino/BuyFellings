//
//  FeelingScreenViewModel.swift
//  BuyFeelings
//
//  Created by israel lacerda gomes santos on 20/10/25.
//
import Foundation
import Observation

@Observable
@MainActor
final class FeelingScreenViewModel {
    var feelingModels: [FeelingActivateModel] = []
    var subscriptions: [SubscriptionModel] = []

    init(databaseManager: any DatabaseProtocol) {
        let purchaseFeelings: [PurchasedFeelingsModel] = databaseManager.getAllElements()
        
        for purchaseFeeling in purchaseFeelings {
            guard let feeling = ProductsIdentifiers(rawValue: purchaseFeeling.name) else { continue }
            let item = FeelingActivateModel(feeling: feeling, image: "", timeInSeconds: "") {
                purchaseFeeling.isActive = true
                databaseManager.update(element: purchaseFeeling)
            }
            self.feelingModels.append(item)
        }
    }
    
    
    
}
