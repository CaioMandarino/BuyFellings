//
//  FeelingsWidgetBundle.swift
//  FeelingsWidget
//
//  Created by Jota Pe on 20/10/25.
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
