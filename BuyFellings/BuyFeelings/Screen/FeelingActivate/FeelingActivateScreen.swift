//
//  FeelingActivateScreen.swift
//  BuyFeelings
//
//  Created by israel lacerda gomes santos on 17/10/25.
//
import SwiftUI

struct FeelingActivateScreen: View {
    @State var viewmodel: FeelingScreenViewModel
    var body: some View {
        Form {
            Section(header: Text("Emotions").font(.largeTitle).foregroundColor(.primary)) {
                if viewmodel.feelingModels.isEmpty {
                    Text("No feelings purchased")
                } else {
                    ForEach(viewmodel.feelingModels) { feeling in
                        FeelingActivateCard(
                            bottle: feeling.image,
                            feeling: ProductsIdentifiers.feelingsToString(feeling: feeling.feeling),
                            timeInSeconds: feeling.timeInSeconds,
                            onActivate: feeling.onActivate
                        )
                    }
                }
            }
            Section(header: Text("Subscriptions").font(.largeTitle).foregroundColor(.primary)) {
                if viewmodel.subscriptions.isEmpty {
                    Text("No subscriptions yet")
                } else {
                    ForEach(viewmodel.subscriptions) { subscription in
                        Text(subscription.title)
                            .font(.headline)
                    }
                }
            }
        }
    }
}
