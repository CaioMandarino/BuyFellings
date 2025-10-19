//
//  ContentViewModel.swift
//  BuyFellings
//
//  Created by Caio Mandarino on 15/10/25.
//

import Foundation
import Combine
import SwiftData

final class ContentViewModel: ObservableObject {
    
    let paymentService: any StoreKitProtocol
    let databaseService: any DatabaseProtocol
    
    init(paymentService: any StoreKitProtocol, databaseService: any DatabaseProtocol) {
        self.paymentService = paymentService
        self.databaseService = databaseService
    }
    
    func purchase(product: ProductsIdentifiers) async {
        let status = try? await paymentService.purchase(product: product)
        
        let allEntities: [PurchasedFeelingsModel] = databaseService.getAllElements()
        
        if status == .success {
            if let element = allEntities.first(where: { $0.name == ProductsIdentifiers.fun.rawValue}) {
                element.duration += 60
                databaseService.update(element: element)
            } else {
                databaseService.add(element: PurchasedFeelingsModel(id: UUID(), name: ProductsIdentifiers.fun.rawValue, duration: 60))
            }
        }
    }
    
}
