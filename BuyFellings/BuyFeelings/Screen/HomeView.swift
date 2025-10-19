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
    @State private var feelingPhase = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                
                Text(viewModel.timeRemaining.formatTime())
                    .digitStyle(font: .largeTitle, value: Int(viewModel.timeRemaining))
    
                Image("Heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
                    .breathingPulse()
                
                Spacer()
                
                Text(feelingPhase.isEmpty ? "Thinking..." : feelingPhase)
                    .font(.title3)
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("", systemImage: "pencil") {
                        
                    }
                }
            }
            .background {
                LinearGradient(colors: viewModel.feelingsColors, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                    .opacity(0.5)
            }
            .task {
                feelingPhase = ""
                guard let feelingPhase = try? await viewModel.getFeelingPhrase() else { return }
                self.feelingPhase = feelingPhase
            }
            .onChange(of: scenePhase) { _  , newValue in
                if newValue != .active {
                    viewModel.persistTimeRemaining()
                }
            }
        }
    }
}


