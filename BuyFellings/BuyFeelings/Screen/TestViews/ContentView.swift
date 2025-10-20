//
//  ContentView.swift
//  BuyFellings
//
//  Created by Caio Mandarino on 15/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("+60 seconds")
                    .font(.largeTitle)
                
                ForEach(ProductsIdentifiers.feelings(for: .badFeelings), id: \.self) { feeling in
                    Button ("Buy \(ProductsIdentifiers.feelingsToString(feeling: feeling))") {
                        Task {
                            await viewModel.purchase(product: feeling)
                        }
                    }
                }
                
            }
        }
        
        .padding()
    }
}
