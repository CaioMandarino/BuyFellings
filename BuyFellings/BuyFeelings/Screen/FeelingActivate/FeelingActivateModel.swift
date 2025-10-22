//
//  FeelingActivateModel.swift
//  BuyFeelings
//
//  Created by israel lacerda gomes santos on 17/10/25.
//

import Foundation
import SwiftUI

struct FeelingActivateModel : Identifiable {
    let id: UUID = UUID()
    let feeling: ProductsIdentifiers
    let image: String
    let timeInSeconds: String
    let isActive: Bool
    let onActivate: () -> Void
    
    init(feeling: ProductsIdentifiers, timeInSeconds: String, isActive: Bool, onActivate: @escaping () -> Void) {
        self.isActive = isActive
        self.feeling = feeling
        self.image = ProductsIdentifiers.feelingsToImage(feeling: feeling)
        self.timeInSeconds = timeInSeconds
        self.onActivate = onActivate
    }

}
