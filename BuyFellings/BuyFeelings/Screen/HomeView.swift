//
//  HomeView.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 17/10/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                
                Text("00:00")
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
                
                Text("O amor está no ar")
                    .font(.title)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("", systemImage: "pencil") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
