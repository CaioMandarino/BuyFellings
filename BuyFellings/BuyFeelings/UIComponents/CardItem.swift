//
//  CardItem.swift
//  BuyFeelings
//
//  Created by Larissa Kailane on 17/10/25.
//

import Foundation
import SwiftUI

struct CardItem: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
    let price: String
    let image: String
    let category: ProductsIdentifiers.Categories
    let productID: ProductsIdentifiers
    var isPurchased: Bool = false   // novo para tentar fazer os coracoes funcionarem
    var isActive: Bool = false      // esse aqui também
}
