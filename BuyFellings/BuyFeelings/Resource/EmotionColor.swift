//
//  EmotionColor.swift
//  BuyFeelings
//
//  Created by JotaPe on 20/10/25.
//

import Foundation
import SwiftUI

extension ProductsIdentifiers {
    
    var gradientColors: [Color] {
        switch self {
        // MARK: - Good Feelings
        case .joy:
            return [Color("Joy"), .yellow]
        case .love:
            return [Color("Love"), .red]
        case .enthusiasm:
            return [Color("Entusiasm"), .orange]
        case .patience:
            return [Color("Patience"), .green]
        case .hope:
            return [Color("Hope"), .teal]
        case .gratitude:
            return [Color("Gratitude"), .yellow]
            
        // MARK: - Bad Feelings
        case .anxiety:
            return [Color("Anxiety"), .purple]
        case .sadness:
            return [Color("Sadness"), .blue]
        case .guilt:
            return [Color("Guilt"), .brown]
        case .anguish:
            return [Color("Anguish"), .indigo]
        case .shame:
            return [Color("Shame"), .pink]
        case .anger:
            return [Color("Anger"), .red]
            
        // MARK: - Seasonal & Others
        case .fear:
            return [Color("Fear"), .black]
        case .affliction:
            return [Color("Affliction"), .gray]
        case .paranoia:
            return [Color("Paranoia"), .purple]
        case .creativity:
            return [Color("Creativity"), .orange]
        case .companionship:
            return [Color("Companionship"), .cyan]
        case .fun:
            return [Color("Fun"), .mint]
            
        // Casos que não têm cores, como assinaturas
        default:
            return [.gray, .white]
        }
    }
}

