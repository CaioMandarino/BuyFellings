//
//  FeelingsWidgetBundle.swift
//  FeelingsWidget
//
//  Created by Caio Mandarino on 24/10/25.
//

import WidgetKit
import SwiftUI

@main
struct FeelingsWidgetBundle: WidgetBundle {
    var body: some Widget {
        FeelingsWidget()
        FeelingsWidgetControl()
        FeelingsWidgetLiveActivity()
    }
}
