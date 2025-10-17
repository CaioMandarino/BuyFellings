//
//  FeelingActivateScreen.swift
//  BuyFeelings
//
//  Created by israel lacerda gomes santos on 17/10/25.
//
import SwiftUI


struct FeelingActivateScreen: View {
    
    let goodFeelings = ProductsIdentifiers.feelings(for: .goodFeelings)
    let badFeelings = ProductsIdentifiers.feelings(for: .badFeelings)
    
    var body: some View {
        
        for feeling in goodFeelings {
            Section {
                FeelingActivateCard(
                    bottle: "",
                    feeling: "", // usar a funcão que gera os nomes
                    timeInSeconds: "") {
                        <#code#>
                    }
            }
        }
        
        
        
    }
}



