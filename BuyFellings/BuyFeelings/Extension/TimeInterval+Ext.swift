//
//  TimeInterval+Ext.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 19/10/25.
//

import Foundation

extension TimeInterval {
    func formatTime() -> String {
        let seconds = Int(self) % 60
        let minutes = (Int(self) / 60)
      
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
