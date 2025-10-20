//
//  BuyFellingsApp.swift
//  BuyFellings
//
//  Created by Caio Mandarino on 15/10/25.
//

import SwiftUI

@main
struct BuyFellingsApp: App {
    @UIApplicationDelegateAdaptor var appDelegate: CustomAppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    appDelegate.app = self
                }
        }
    }
}
