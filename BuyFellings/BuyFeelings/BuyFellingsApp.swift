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
    let feelingScreenViewModel: FeelingScreenViewModel
    
    init() {
        container = try! ModelContainer(for: PurchasedFeelingsModel.self)
        let context = container.mainContext
        let storeKitService = StoreKitManager()
        let databaseService = DatabaseManager(context: context)
        let foundationService = FMSessionConfiguration()
            
        contentViewModel = .init(paymentService: storeKitService, databaseService: databaseService)
        homeViewModel = .init(databaseService: databaseService, foundationService: foundationService)
        feelingScreenViewModel = .init(databaseManager: databaseService)
    }
    
    var body: some Scene {
        WindowGroup {
            BuyFeelingsTabView(homeViewModel: homeViewModel, contentViewModel: contentViewModel, FeelingScreenViewModel: feelingScreenViewModel)
        }
        .modelContainer(container)
    }
}
