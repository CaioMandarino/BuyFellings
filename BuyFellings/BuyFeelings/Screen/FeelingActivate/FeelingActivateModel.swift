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
    let onActivate: () -> Void
    
    init(feeling: ProductsIdentifiers, timeInSeconds: String, onActivate: @escaping () -> Void) {
        self.feeling = feeling
        self.image = ProductsIdentifiers.feelingsToImage(feeling: feeling)
        self.timeInSeconds = timeInSeconds
        self.onActivate = onActivate
    }
}
