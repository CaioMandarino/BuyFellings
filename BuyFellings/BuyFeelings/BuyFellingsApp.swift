//
//  BuyFellingsApp.swift
//  BuyFellings
//
//  Created by Caio Mandarino on 15/10/25.
//

import SwiftUI
import SwiftData

@main
struct BuyFellingsApp: App {
    
    let container: ModelContainer
    let contentViewModel: ContentViewModel
    
    init() {
        container = try! ModelContainer(for: PurchasedFeelingsModel.self)
        let context = container.mainContext
        let storeKitService = StoreKitManager()
        let databaseService = DatabaseManager(context: context)
            
        contentViewModel = .init(paymentService: storeKitService, databaseService: databaseService)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: contentViewModel)
        }
        .modelContainer(container)
    }
}
