//
//  CardComponentCarousel.swift
//  BuyFeelings
//
//  Created by Raquel Souza on 17/10/25.
//

import SwiftUI

struct CardComponentCarousel: View {
    
    let items: [CardItem]
    
    var body: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(items.filter({ $0.category == .badFeelings})) { item in
                        CardComponent(item: item)
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
                    .font(.title3.bold())
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, -8)
        }
        
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(items.filter({ $0.category == .goodFeelings})) { item in
                        CardComponent(item: item)
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
                Text("Good Feelings")
                    .font(.title3.bold())
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, -8)
        }
        
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(items.filter({ $0.category == .sessionBadFeelings})) { item in
                        CardComponent(item: item)
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
                Text("Halloween Bad Feelings")
                    .font(.title3.bold())
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, -8)
        }
        
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(items.filter({ $0.category == .sessionGoodFeelings})) { item in
                        CardComponent(item: item)
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
                Text("Halloween Good Feelings")
                    .font(.title3.bold())
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, -8)
        }
    }
}
