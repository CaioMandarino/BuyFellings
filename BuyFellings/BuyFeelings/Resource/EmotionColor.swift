//
//  EmotionColor.swift
//  BuyFeelings
//
//  Created by Jota Pe on 20/10/25.
//

import Foundation
import SwiftUI

extension ProductsIdentifiers {
    
    var gradientColors: [Color] {
        switch self {
        // MARK: - Good Feelings
        case .joy:
            return [Color.joy]
        case .love:
            return [Color.love]
        case .enthusiasm:
            return [Color.enthusiasm]
        case .patience:
            return [Color.patience]
        case .hope:
            return [Color.hope]
        case .gratitude:
            return [Color.gratitude]
            
        // MARK: - Bad Feelings

        case .anxiety:
            return [Color.anxiety]
        case .sadness:
            return [Color.sadness]
        case .guilt:
            return [Color.guilt]
        case .anguish:
            return [Color.anguish]
        case .shame:
            return [Color.shame]
        case .anger:
            return [Color.anger]
            
        // MARK: - Seasonal & Others
        case .fear:
            return [Color.fear]
        case .affliction:
            return [Color.affliction]
        case .paranoia:
            return [Color.paranoia]
        case .creativity:
            return [Color.creativity]
        case .companionship:
            return [Color.companionship]
        case .fun:
            return [Color.fun]
        default:
            // Ajustado para retornar um array de cor
            return [.gray]
        }
    }
}
