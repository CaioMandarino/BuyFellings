//
//  Fellings.swift
//  BuyFellings
//
//  Created by Caio Mandarino on 15/10/25.
//

import Foundation

enum Fellings {
    enum Bad: String, CaseIterable {
        case anxiety  = "com.CaioMandarino.BuyFellings.bad.anxiety"
        case sadness  = "com.CaioMandarino.BuyFellings.bad.sadness"
        case guilt    = "com.CaioMandarino.BuyFellings.bad.guilt"
        case anguish  = "com.CaioMandarino.BuyFellings.bad.anguish"
        case shame    = "com.CaioMandarino.BuyFellings.bad.shame"
        case anger    = "com.CaioMandarino.BuyFellings.bad.anger"
    }

    enum Good: String, CaseIterable {
        case joy         = "com.CaioMandarino.BuyFellings.good.joy"
        case love        = "com.CaioMandarino.BuyFellings.good.love"
        case enthusiasm  = "com.CaioMandarino.BuyFellings.good.enthusiasm"
        case patience    = "com.CaioMandarino.BuyFellings.good.patience"
        case hope        = "com.CaioMandarino.BuyFellings.good.hope"
        case gratitude   = "com.CaioMandarino.BuyFellings.good.gratitude"
    }

    enum Seasonal: String, CaseIterable {
        case fear           = "com.CaioMandarino.BuyFellings.seasonal.fear"
        case creativity     = "com.CaioMandarino.BuyFellings.seasonal.creativity"
        case companionship  = "com.CaioMandarino.BuyFellings.seasonal.companionship"
        case fun            = "com.CaioMandarino.BuyFellings.seasonal.fun"
        case affliction     = "com.CaioMandarino.BuyFellings.seasonal.affliction"
        case paranoia       = "com.CaioMandarino.BuyFellings.seasonal.paranoia"
    }
}
