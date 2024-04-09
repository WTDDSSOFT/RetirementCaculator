//
//  RetirmentCalculatorApp.swift
//  RetirmentCalculator
//
//  Created by willaim santos on 09/04/24.
//

import SwiftUI
import SwiftData
import AppCenter
import AppCenterCrashes
import AppCenterAnalytics

@main
struct RetirmentCalculatorApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
    
    init () {
        AppCenter.start(withAppSecret: "8313681b-5fa3-4360-9d86-e3b4a46c4f7b", services: [Crashes.self, Analytics.self])
        Analytics.trackEvent("App_initialize_success")
    }
}
