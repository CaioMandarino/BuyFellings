//
//  ProductsIdentifiers.swift
//  BuyFellings
//
//  Created by Caio Mandarino on 15/10/25.
//

import Foundation
import SwiftUI

enum ProductsIdentifiers: String, CaseIterable {
    case premiumMonthly
    case premiumQuarterly
    case premiumYearly
    case season
    
    // MARK: - Bad Feelings
    case anxiety  = "com.CaioMandarino.BuyFellings.bad.anxiety"
    case sadness  = "com.CaioMandarino.BuyFellings.bad.sadness"
    case guilt    = "com.CaioMandarino.BuyFellings.bad.guilt"
    case anguish  = "com.CaioMandarino.BuyFellings.bad.anguish"
    case shame    = "com.CaioMandarino.BuyFellings.bad.shame"
    case anger    = "com.CaioMandarino.BuyFellings.bad.anger"
    
    // MARK: - Good Feelings
    case joy         = "com.CaioMandarino.BuyFellings.good.joy"
    case love        = "com.CaioMandarino.BuyFellings.good.love"
    case enthusiasm  = "com.CaioMandarino.BuyFellings.good.enthusiasm"
    case patience    = "com.CaioMandarino.BuyFellings.good.patience"
    case hope        = "com.CaioMandarino.BuyFellings.good.hope"
    case gratitude   = "com.CaioMandarino.BuyFellings.good.gratitude"
    
    // MARK: - Session Bad
    case fear           = "com.CaioMandarino.BuyFellings.seasonal.fear"
    case affliction     = "com.CaioMandarino.BuyFellings.seasonal.affliction"
    case paranoia       = "com.CaioMandarino.BuyFellings.seasonal.paranoia"
    
    // MARK: - Session Good
    case creativity     = "com.CaioMandarino.BuyFellings.seasonal.creativity"
    case companionship  = "com.CaioMandarino.BuyFellings.seasonal.companionship"
    case fun            = "com.CaioMandarino.BuyFellings.seasonal.fun"

    
    enum Categories {
        case badFeelings
        case goodFeelings
        case sessionBadFeelings
        case sessionGoodFeelings
    }
    
    static func feelings(for category: Categories) -> [ProductsIdentifiers] {
        switch category {
        case .badFeelings:
            return [.anxiety, .sadness, .guilt, .anguish, .shame, .anger]
        case .goodFeelings:
            return [.joy, .love, .enthusiasm, .patience, .hope, .gratitude]
        case .sessionBadFeelings:
            return [.fear, .affliction, .paranoia]
        case .sessionGoodFeelings:
            return [.creativity, .fun, .companionship]
        }
    }
    
    static func feelingsToImage(feeling: ProductsIdentifiers) -> Image {
        switch feeling {
        case .anxiety:
            return Image("anxiety")
        case .sadness:
            return Image("sadness")
        case .guilt:
            return Image("guilt")
        case .anguish:
            return Image("anguish")
        case .shame:
            return Image("shame")
        case .anger:
            return Image("anger")
        default:
            return Image("Unknown")
        }
    }
}
