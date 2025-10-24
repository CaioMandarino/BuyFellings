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
        let userDefaults = UserDefaults(suiteName: Shared.groupID)
        
        let emotionID = userDefaults?.string(forKey: Shared.feelingID) ?? ""
        
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
        let originalColors = entry.emotion?.gradientColors ?? .gray
        
        let gradient = LinearGradient(
            colors: [originalColors.opacity(0.5), originalColors],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
    
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

#Preview("Small", as: .systemSmall) {
    FeelingsWidget()                // seu tipo que conforma a `Widget`
} timeline: {
    SimpleEntry(date: .now, emotion: nil)
}
