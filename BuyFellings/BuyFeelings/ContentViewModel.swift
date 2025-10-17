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
    
    @Published var duration: TimeInterval
    
    var allEntities: [PurchasedFeelingsModel]
    let paymentService: any StoreKitProtocol
    let databaseService: any DatabaseProtocol
    
    init(paymentService: any StoreKitProtocol, databaseService: any DatabaseProtocol) {
        self.paymentService = paymentService
        self.databaseService = databaseService
        
        let descriptor: FetchDescriptor<PurchasedFeelingsModel> = .init()
        allEntities = databaseService.getAllElements(fetchDescriptor: descriptor)
        duration = allEntities.first { $0.name == ProductsIdentifiers.fun.rawValue }?.duration ?? 0
    }
    
    func purchase() async {
        let status = try? await paymentService.purchase(product: .fun)
        
        if status == .success {
            if let element = allEntities.first(where: { $0.name == ProductsIdentifiers.fun.rawValue}) {
                element.duration += 60
                duration = element.duration
                databaseService.update(element: element)
            } else {
                duration = 60
                databaseService.add(element: PurchasedFeelingsModel(id: UUID(), name: ProductsIdentifiers.fun.rawValue, duration: 60))
            }
        }
    }
    
}
