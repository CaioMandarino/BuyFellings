//
//  PencilView.swift
//  BuyFeelings
//
//  Created by Raquel Souza on 22/10/25.
//

import SwiftUI

struct EditHeartView: View {
    @ObservedObject var viewModel: EditHeartViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.cards.filter({ $0.category == .hearts})) { item in
                    CardHeartComponent(viewModel: viewModel, item: item)
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 10)
                }
            }
            .scrollTargetLayout()

        }
        .frame(maxWidth: .infinity)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
    }
}
