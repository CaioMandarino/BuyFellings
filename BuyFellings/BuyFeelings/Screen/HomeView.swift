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
    @ObservedObject var viewModelHeart: EditHeartViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                
                Text(viewModel.timeRemaining.formatTime())
                    .digitStyle(font: .largeTitle, value: Int(viewModel.timeRemaining))
    
                Image(viewModelHeart.activeHeartName ?? "Heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .breathingPulse()
                
                Spacer()
                
                Text(viewModel.feelingPhase.isEmpty ? "Thinking..." : viewModel.feelingPhase)
                    .font(.title3)
                
                if viewModel.showEditMode {
                    EditHeartView(viewModel: viewModelHeart)
                }
                
                Spacer()
                
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Heart View", systemImage: viewModel.showEditMode ? "xmark": "pencil") {
                        viewModel.showEditMode.toggle()
                    }
                }
            }
            .background {
                LinearGradient(colors: viewModel.feelingsColors, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                    .opacity(0.5)
            }
            .task {
                viewModel.feelingPhase = ""
                guard let feelingPhase = try? await viewModel.getFeelingPhrase() else { return }
                viewModel.feelingPhase = feelingPhase
                
                await requestPermission()
            }
            .onChange(of: scenePhase) { _  , newValue in
                if newValue != .active {
                    viewModel.persistTimeRemaining()
                }
            }
            
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


