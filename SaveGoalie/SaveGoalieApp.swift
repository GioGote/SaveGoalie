//
//  SaveGoalieApp.swift
//  SaveGoalie
//
//

import SwiftUI
import SwiftData

@main
struct SaveGoalieApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: SavingsGoal.self)
    }
}
