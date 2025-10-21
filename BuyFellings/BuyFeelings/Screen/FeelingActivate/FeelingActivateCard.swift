//
//  FeelingActivateCard.swift
//  BuyFeelings
//
//  Created by israel lacerda gomes santos on 17/10/25.
//
import SwiftUI

struct FeelingActivateCard: View {
    // variables
    let bottle: String
    let feeling: String
    let timeInSeconds: String
    let isActive: Bool
    let onActivate: () -> Void
    
    var body: some View {
        HStack {
            Image(bottle)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 50, maxHeight: 50)
            Spacer()
            VStack (alignment: .leading) {
                Text(feeling)
                    .font(.headline)
                Text(timeInSeconds)
                    .font(.caption)
            }
            Spacer()
            Button(action: onActivate) {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                        .frame(width: 90, height: 40)
                    Text("Ativar")
                        .foregroundStyle(Color(.white))
                }
            }
            .disabled(isActive)
        }
    }
}

