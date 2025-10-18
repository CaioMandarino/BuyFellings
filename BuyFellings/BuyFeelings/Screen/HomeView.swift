//
//  HomeView.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 17/10/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel: HomeViewModel
    @State private var feelingPhase = "Thinking..."
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                
                Text(viewModel.timeRemaining.formatted())
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .monospacedDigit()
                    .padding()
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 64)
                    .foregroundStyle(.red)
                    .symbolEffect(.bounce)
                
                Spacer()
                
                Text(feelingPhase)
                    .font(.title)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("", systemImage: "pencil") {
                        
                    }
                }
            }
            .task {
                feelingPhase = await viewModel.getFeelingPhrase()
            }
            .onChange(of: scenePhase) { _  , newValue in
                if newValue != .active {
                    viewModel.persistTimeRemaining()
                }
            }
        }
    }
}


