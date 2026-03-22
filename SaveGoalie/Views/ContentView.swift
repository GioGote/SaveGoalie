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
    
    var body: some View{
        TabView(selection: $selectedTab) {
            Tab(value: 0){
                GoalsView(selectedTab: $selectedTab)
            }
            
            Tab(value: 1){
                GoalHistoryView()
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .overlay(alignment: .bottom){
            BottomTabBar(selectedTab: $selectedTab, isSavignsGoalViewShowing: $isSavingGoalViewShowing)
                .padding(.horizontal)
                .offset(y: 20)
        }
        .sheet(isPresented: $isSavingGoalViewShowing) {
            NewGoalView(selectedTab: $selectedTab, isSavingsGoalViewShowing: $isSavingGoalViewShowing)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: SavingsGoal.self, inMemory: true)
}
