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
        VStack {
            Text("Fun duration: \(viewModel.duration)")
            
            Button ("Buy Fun duration") {
                Task {
                    await viewModel.purchase()
                }
            }
            
        }
        .padding()
    }
}
