//
//  FeelingActivateScreen.swift
//  BuyFeelings
//
//  Created by israel lacerda gomes santos on 17/10/25.
//
import SwiftUI


import SwiftUI

struct FeelingActivateScreen: View {
    // galerinha que vai mecher com a mudanca de cor baseada no sentimento e o tempo dos sentimentos
    //o array segue o modelo : id - feeling - image - timeInSeconds - onActivate
    // basta passar a execucão expecifica pra cada sentimento 8)
    // caso tenha duvida veja o FeelingActivateModel
    var feelingModels: [FeelingActivateModel] = []
    
    init(purchaseFeelings: [PurchasedFeelingsModel], databaseManager: any DatabaseProtocol) {
        for purchaseFeeling in purchaseFeelings {
            guard let feeling = ProductsIdentifiers(rawValue: purchaseFeeling.name) else { continue }
            let item = FeelingActivateModel(feeling: feeling, image: "", timeInSeconds: "") {
                /*
                 purchaseFeeling.isActive = true
                 databaseManager.update(purchaseFeeling)
                 */
            }
            feelingModels.append(item)
        }
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Emotions")
                .font(.largeTitle)
                .padding(.leading, 16)
                .padding(.top, 16)
            Form {
                Section(header: Text("Good Feelings").font(.headline)) {
                    ForEach(feelingModels) { feeling in
                        FeelingActivateCard(
                            bottle: feeling.image ,
                            feeling: ProductsIdentifiers.feelingsToString(feeling: feeling.feeling),
                            timeInSeconds: feeling.timeInSeconds,
                            onActivate: feeling.onActivate
                        )
                    }
                }
            }
            Text("Subscriptions")
                .font(.largeTitle)
                .padding(.leading, 16)
                .padding(.top, 16)
            
            .listStyle(.insetGrouped)
        }
    }
}
