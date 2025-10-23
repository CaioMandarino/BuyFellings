//
//  PurchasedFeelingsModel.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 16/10/25.
//

import Foundation
import SwiftData

@Model
final class PurchasedFeelingsModel {
    var id: UUID
    var name: String
    var duration: TimeInterval
    var isActive: Bool = false
    
    init(id: UUID, name: String, duration: TimeInterval) {
        self.id = id
        self.name = name
        self.duration = duration
    }
}

@Model
final class PurchasedHearts {
    var id: UUID
    var name: String
    var isActive: Bool = false
    
    init(id: UUID, name: String, isActive: Bool = false) {
        self.id = id
        self.name = name
        self.isActive = isActive
    }
}
