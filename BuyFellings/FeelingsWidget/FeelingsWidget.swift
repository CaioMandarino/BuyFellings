//
//  FeelingsWidget.swift
//  FeelingsWidget
//
//  Created by Jota Pe on 20/10/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emotion: nil)
    }

    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emotion: nil)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.com.CaioMandarino.BuyFeelings")
        let emotionID = userDefaults?.string(forKey: "activeEmotionID") ?? ""
        
        let currentEmotion = ProductsIdentifiers(rawValue: emotionID)
        
        let entry = SimpleEntry(date: Date(), emotion: currentEmotion)

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}


struct SimpleEntry: TimelineEntry {
    let date: Date
    let emotion: ProductsIdentifiers?
}

struct FeelingsWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        // ---- INÍCIO DA MODIFICAÇÃO ----
        
        // 1. Pega as cores originais que vêm do app
        let originalColors = entry.emotion?.gradientColors ?? [Color.gray, Color.white.opacity(0.5)]
        
        // 2. Decide qual é a "cor principal"
        //    - Se a emoção NÃO for nil (ex: "Sadness"), pegamos a segunda cor (a mais escura, índice 1)
        //    - Se a emoção FOR nil (estado "Nada"), pegamos a primeira cor (o cinza, índice 0)
        let mainColor = entry.emotion != nil ? originalColors[1] : originalColors[0]
        
        // 3. Cria um array de cores para o gradiente usando APENAS a cor principal.
        //    Isso resultará em um fundo de cor sólida, removendo o "branco".
        let backgroundColors = [mainColor, mainColor]

        // 4. Cria o gradiente (que agora será de cor sólida)
        let gradient = LinearGradient(
            gradient: Gradient(colors: backgroundColors),
            startPoint: .top,
            endPoint: .bottom
        )
        
        // ---- FIM DA MODIFICAÇÃO ----
    
        VStack(spacing: 4) {
            Text("Seu Coração Está Sentindo:")
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
            
            if let currentEmotion = entry.emotion {
            
                Text(ProductsIdentifiers.feelingsToString(feeling: currentEmotion))
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundColor(.white)
            } else {

                Text("Nada")
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .padding()
        .multilineTextAlignment(.center)
        .containerBackground(gradient, for: .widget)
    }
}


struct FeelingsWidget: Widget {
    let kind: String = "FeelingsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            
            FeelingsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Meu Sentimento")
        .description("Veja o sentimento atual do seu coração.")
        .supportedFamilies([.systemSmall])
    }
}
