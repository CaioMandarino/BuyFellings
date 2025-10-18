//
//  ActiveFeelingTest.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 18/10/25.
//

import SwiftUI
import SwiftData

struct ActiveFeelingTest: View {
    @Query(sort: \PurchasedFeelingsModel.name) var allFeelings: [PurchasedFeelingsModel]
    let databaseManager: any DatabaseProtocol
    
    var body: some View {
        ScrollView {
            ForEach(allFeelings) { feeling in
                HStack {
                    VStack(alignment: .leading) {
                        Text(feeling.name)
                        Text("\(feeling.duration)")
                    }
                    
                    Button("Active") {
                        feeling.isActive.toggle()
                        databaseManager.update(element: feeling)
                    }
                    .disabled(feeling.isActive)
                    .opacity(feeling.isActive ? 0.5 : 1)
                }
                .padding()
            }
        }
        .padding()
    }
}

