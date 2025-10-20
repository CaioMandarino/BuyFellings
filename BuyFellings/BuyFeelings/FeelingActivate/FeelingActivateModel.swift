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
    let feeling: String
    let image: ImageResource
    let timeInSeconds: String
    let onActivate: () -> Void
}
