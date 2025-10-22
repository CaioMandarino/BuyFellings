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
        
        let originalColors = entry.emotion?.gradientColors ?? [Color.gray, Color.white.opacity(0.5)]
    
        let mainColor = originalColors[0]
        
        let backgroundColors = [mainColor, mainColor]

        let gradient = LinearGradient(
            gradient: Gradient(colors: backgroundColors),
            startPoint: .top,
            endPoint: .bottom
        )
        
        var colorText: Color {
            if backgroundColors[0] == .anguish || backgroundColors[0] == .paranoia || backgroundColors[0] == .affliction || backgroundColors[0] == .love || backgroundColors[0] == .anxiety {
                return .white
            }
            else {
                return .black
            }
        }
        
    
        VStack(spacing: 4) {
            Text("Seu Coração Está Sentindo:")
                .font(.caption)
                .foregroundColor(colorText.opacity(0.8))
            
            if let currentEmotion = entry.emotion {
            
                Text(ProductsIdentifiers.feelingsToString(feeling: currentEmotion))
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundColor(colorText)
            } else {

                Text("Nada")
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundColor(colorText)
            }
        }
        .padding()
        .multilineTextAlignment(.center)
        .containerBackground(gradient, for: .widget)
        .onAppear {
            print("GradientColors: ", entry.emotion?.gradientColors)
        }
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
