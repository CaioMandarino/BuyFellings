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
        case .creativity:
            return Image("creativity")
        default:
            return Image("Unknown")
        }
    }
    
    static func feelingsToString(feeling: ProductsIdentifiers) -> String {
        switch feeling {
        case .anxiety:
            return "Anxiety"
        case .sadness:
            return "Sadness"
        case .guilt:
            return "Guilt"
        case .anguish:
            return "Anguish"
        case .shame:
            return "Shame"
        case .anger:
            return "Anger"
        case .joy:
            return "Joy"
        case .love:
            return "Love"
        case .enthusiasm:
            return "Enthusiasm"
        case .patience:
            return "Patience"
        case .hope:
            return "Hope"
        case .gratitude:
            return "Gratitude"
        case .fear:
            return "Fear"
        case .affliction:
            return "Affliction"
        case .paranoia:
            return "Paranoia"
        case .creativity:
            return "Creativity"
        case .companionship:
            return "Companionship"
        case .fun:
            return "Fun"
        default:
            return "Unknown"
        }
    }
}
