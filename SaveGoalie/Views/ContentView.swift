//
//  ContentView.swift
//  SaveGoalie
//
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isSavingGoalViewShowing = false
    @Environment(\.modelContext) private var modelContext
    
    // TODO: REFACTOR FROM TABVIEW TO PAGES (atleast for the new goalView)
    var body: some View{
        TabView(selection: $selectedTab) {
            Tab(value: 0){
                GoalsView(selectedTab: $selectedTab)
            }
            Tab(value: 1){
                NewGoalView(selectedTab: $selectedTab)
            }
            Tab(value: 2){
                SettingsView()
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .overlay(alignment: .bottom){
            BottomTabBar(selectedTab: $selectedTab)
                .padding(.horizontal)
                .offset(y: 20)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: SavingsGoal.self, inMemory: true)
}
