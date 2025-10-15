//
//  StoreKitManager.swift
//  BuyFellings
//
//  Created by Caio Mandarino on 15/10/25.
//

import Foundation
import StoreKit

actor StoreKitManager {
    
    private var purchaseProducts: Set<ProductsIdentifiers> = []
    
    private var taskObservePurchase: Task<Void, Never>? = nil
    
    init() {
        Task {
            await fetchPurchaseProducts()
            await observePurchase()
        }
    }
    
    private func fetchPurchaseProducts() async {
        var new: Set<ProductsIdentifiers> = []
        
        for await transaction in Transaction.currentEntitlements {
            guard let result = try? checkVerified(transaction) else { continue }
            
            if result.revocationDate != nil { continue }
            if let date = result.expirationDate, date < Date() { continue }
            
            await result.finish()
            guard let id = try? convertProductIdentifier(for: result.productID) else { continue }
            new.insert(id)
        }
        
        purchaseProducts = new
    }
    
    private func observePurchase() {
        taskObservePurchase = Task(priority: .background) {
            for await transaction in Transaction.updates {
                guard let result = try? checkVerified(transaction) else { continue }
                await result.finish()
                await fetchPurchaseProducts()
            }
        }
    }
    
    nonisolated private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreKitErrors.notVerified
        case .verified(let safe):
            return safe
        }
    }
    
    private func convertProductIdentifier(for productID: String) throws -> ProductsIdentifiers {
        guard let id = ProductsIdentifiers(rawValue: productID) else {
            throw StoreKitErrors.productIDNotFound
        }
        
        return id
    }
    
    private func purchase(_ product: Product) async throws -> PurchaseResults {
        guard let result = try? await product.purchase() else {
            throw StoreKitErrors.purchaseFailed
        }
        
        switch result {
        case .success(let transaction):
            let result = try checkVerified(transaction)
            await result.finish()
            await fetchPurchaseProducts()
            return .success
            
        case .pending: return .pending
            
        case .userCancelled: return .userCancelled
            
        @unknown default: throw StoreKitErrors.purchaseFailed
        }
    }
    
    deinit {
        taskObservePurchase?.cancel()
        taskObservePurchase = nil
    }
}

// MARK: - Public API
extension StoreKitManager {
    func purchase(product: ProductsIdentifiers) async throws -> PurchaseResults {
        guard let product = try? await Product.products(for: [product.rawValue]).first else {
            throw StoreKitErrors.productIDNotFound
        }
        
        return try await purchase(product)
    }
    
    func price(product: ProductsIdentifiers) async throws -> String {
        guard let product = try? await Product.products(for: [product.rawValue]).first else {
            throw StoreKitErrors.productIDNotFound
        }
        
        return product.displayPrice 
    }
}




