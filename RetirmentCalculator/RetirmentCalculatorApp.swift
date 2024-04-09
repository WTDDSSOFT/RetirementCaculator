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
        AppCenter.start(withAppSecret: "e6400890-b85f-4ed8-af9b-eeefea0e70b4", services: [Crashes.self, Analytics.self])
    }
}
