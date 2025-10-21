//
//  Color+Ext.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 20/10/25.
//

import SwiftUI

extension Color {
    init(for productIdentifier: ProductsIdentifiers) {
        let feelingName = ProductsIdentifiers.feelingsToString(feeling: productIdentifier)
        self.init(feelingName)
    }
}
