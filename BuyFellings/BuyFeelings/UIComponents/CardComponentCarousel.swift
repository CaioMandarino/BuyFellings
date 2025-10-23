//
//  CardComponentCarousel.swift
//  BuyFeelings
//
//  Created by Raquel Souza on 17/10/25.
//

import SwiftUI

struct CardComponentCarousel: View {
    
    @ObservedObject var viewModel: BuyEmotionsViewModel
    
    let items: [CardItem]
    
    var body: some View {
        Text("Feelings for you!")
            .font(.system(size: 28, weight: .bold, design: .monospaced))
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

        
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(items.filter({ $0.category == .badFeelings})) { item in
                        CardComponent(viewModel: viewModel, item: item)
                            .frame(width: 340, height: 280)
                            .padding(.vertical)
                    }
                }
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal)
            .scrollTargetBehavior(.viewAligned)
        } header: {
            HStack {
                Text("Bad Feelings")
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top)
            .padding(.bottom, -8)
        }
        
        
        // MARK: - Seção Happiness Subscription
        Section {
            // Banner fixo usando o CardSubscriptionComponent
            if let item = items.first(where: { $0.productID == .premiumMonthly }) {
                CardSubscriptionComponent(viewModel: viewModel, item: item, haveBuy: viewModel.userHavePremium)
                    .frame(width: 340, height: 130)
                    .frame(maxWidth: .infinity)
            }
        } header: {
            HStack {
                Text("Happiness is the way!")
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundColor(Color.black)

                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top)
            .padding(.bottom, -3)
        }
        
        

        
        
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(items.filter({ $0.category == .goodFeelings})) { item in
                        if viewModel.userHavePremium {
                            CardComponent(viewModel: viewModel, item: item)
                                .frame(width: 340, height: 280)
                                .padding(.vertical)
                        } else {
                            CardComponentLocked(viewModel: viewModel, item: item)
                                .frame(width: 340, height: 280)
                                .padding(.vertical)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal)
            .scrollTargetBehavior(.viewAligned)
        } header: {
            HStack {
                Text("Good Feelings")
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundColor(Color.gray)

                Spacer()
            }
            .padding(.horizontal,30)
            .padding(.top)
            .padding(.bottom, -8)
        }
        
        
        // MARK: - Seção Halloween Subscription
        Section {
            // Banner fixo usando o CardSubscriptionComponent
            if let item = items.first(where: { $0.productID == .season }) {
                CardSubscriptionComponent(viewModel: viewModel, item: item, haveBuy: viewModel.userHavePremiumSession)
                    .frame(width: 340, height: 130)
                    .frame(maxWidth: .infinity)
            }
        } header: {
            HStack {
                Text("Halloween season!")
                    .font(.system(size: 18, weight: .bold, design: .monospaced))

                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top)
            .padding(.bottom, -3)
        }

        
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(items.filter({ $0.category == .sessionBadFeelings})) { item in
                        if viewModel.userHavePremiumSession {
                            CardComponent(viewModel: viewModel, item: item)
                                .frame(width: 340, height: 280)
                                .padding(.vertical)
                        } else {
                            CardComponentLocked(viewModel: viewModel, item: item)
                                .frame(width: 340, height: 280)
                                .padding(.vertical)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal)
            .scrollTargetBehavior(.viewAligned)
        } header: {
            HStack {
                Text("Halloween: Bad Feelings")
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundColor(Color.gray)

                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top)
            .padding(.bottom, -8)
        }
        
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(items.filter({ $0.category == .sessionGoodFeelings})) { item in
                        if viewModel.userHavePremiumSession {
                            CardComponent(viewModel: viewModel, item: item)
                                .frame(width: 340, height: 280)
                                .padding(.vertical)
                        } else {
                            CardComponentLocked(viewModel: viewModel, item: item)
                                .frame(width: 340, height: 280)
                                .padding(.vertical)
                        }
                    }

                }
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal)
            .scrollTargetBehavior(.viewAligned)
        } header: {
            HStack {
                Text("Halloween: Good Feelings")
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundColor(Color.gray)

                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top)
            .padding(.bottom, -8)
        }
    }
}
