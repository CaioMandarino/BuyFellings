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
    
    let goodFeelingModels: [FeelingActivateModel] = [
        FeelingActivateModel(
            feeling: "Joy",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Love",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Enthusiasm",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Patience",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Hope",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Gratitude",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        )
    ]
    let badFeelingModels: [FeelingActivateModel] = [
        FeelingActivateModel(
            feeling: "Anxiety",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Sadness",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Guilt",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Anguish",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Shame",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Anger",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        )
    ]
    let seasonalFeelingModels: [FeelingActivateModel] = [
        FeelingActivateModel(
            feeling: "Fear",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Affliction",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Paranoia",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Creativity",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Companionship",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        ),
        FeelingActivateModel(
            feeling: "Fun",
            image: .frascoTeste,
            timeInSeconds: "",
            onActivate: {}
        )
    ]
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Emotions")
                .font(.largeTitle)
                .padding(.leading, 16)
                .padding(.top, 16)
            List {
                Section(header: Text("Good Feelings").font(.headline)) {
                    ForEach(goodFeelingModels, id: \.id) { feeling in
                        FeelingActivateCard(
                            bottle: feeling.image ,
                            feeling: feeling.feeling,
                            timeInSeconds: feeling.timeInSeconds,
                            onActivate: feeling.onActivate
                        )
                    }
                }
                Section(header: Text("Bad Feelings").font(.headline)) {
                    ForEach(badFeelingModels, id: \.id) { feeling in
                        FeelingActivateCard(
                            bottle: feeling.image ,
                            feeling: feeling.feeling,
                            timeInSeconds: feeling.timeInSeconds,
                            onActivate: feeling.onActivate
                        )
                    }
                }
                Section(header: Text("Subscriptions").font(.headline)) {
                    ForEach(seasonalFeelingModels, id: \.id) { feeling in
                        FeelingActivateCard(
                            bottle: feeling.image ,
                            feeling: feeling.feeling,
                            timeInSeconds: feeling.timeInSeconds,
                            onActivate: feeling.onActivate
                        )
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}


#Preview {
    FeelingActivateScreen()
}

