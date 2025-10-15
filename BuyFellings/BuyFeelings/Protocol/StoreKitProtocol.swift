//
//  StoreKitProtocol.swift
//  BuyFellings
//
//  Created by Caio Mandarino on 15/10/25.
//

import Foundation
import Combine

protocol StoreKitProtocol {
    var publisherPurchaseProducts: AnyPublisher<Set<ProductsIdentifiers>, Never> { get async }
    var publisherRefundedProducts: AnyPublisher<ProductsIdentifiers, Never> { get async }
    
    func purchase(product: ProductsIdentifiers) async throws -> PurchaseResults
    func price(product: ProductsIdentifiers) async throws -> String
}
