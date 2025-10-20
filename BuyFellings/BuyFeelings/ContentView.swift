//
//  ContentView.swift
//  BuyFellings
//
//  Created by Caio Mandarino on 15/10/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel(service: StoreKitManager() )
    
    var body: some View {
        VStack {
            Text("Fears Count: \(viewModel.fearCount)")
            
            Button ("Buy Fear") {
                Task {
                    await viewModel.purchase()
                }
            }
        }
        .padding()
        .task {
            await requestPermission()
        }
    }
    func requestPermission() async {
        do {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        } catch {
            print("Failed to request permission: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
