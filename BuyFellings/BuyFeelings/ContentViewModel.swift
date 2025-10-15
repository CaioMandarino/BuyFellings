//
//  ContentViewModel.swift
//  BuyFellings
//
//  Created by Caio Mandarino on 15/10/25.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    @Published var fearCount: Int {
        willSet {
            UserDefaults.standard.set(newValue, forKey: Keys.fearCount)
        }
    }
    
    let service: any StoreKitProtocol
    
    init(service: any StoreKitProtocol) {
        self.service = service
        fearCount = UserDefaults.standard.integer(forKey: Keys.fearCount)
    }
    
    func purchase() async {
        let status = try? await service.purchase(product: .fun)
        
        if status == .success {
            fearCount += 1
        }
    }
    
    enum Keys {
        static let fearCount = "fearCount"
    }
}
