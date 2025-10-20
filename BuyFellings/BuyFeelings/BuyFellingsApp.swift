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
    let homeViewModel: HomeViewModel
    let buyEmotionsViewModel: BuyEmotionsViewModel

    init() {
        container = try! ModelContainer(for: PurchasedFeelingsModel.self)
        let context = container.mainContext
        let storeKitService = StoreKitManager()
        let databaseService = DatabaseManager(context: context)
        let foundationService = FMSessionConfiguration()
            
        contentViewModel = .init(paymentService: storeKitService, databaseService: databaseService)
        homeViewModel = .init(databaseService: databaseService, foundationService: foundationService)
        buyEmotionsViewModel = .init(storeKitManager: storeKitService)
    }
    
    var body: some Scene {
        WindowGroup {
            BuyFeelingsTabView(
                homeViewModel: homeViewModel,
                contentViewModel: contentViewModel,
                storeViewModel: buyEmotionsViewModel
            )
        }
        .modelContainer(container)
    }
}
