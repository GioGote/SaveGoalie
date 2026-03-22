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
    @State private var isMenuShowing = false
    @State private var isProfileShowing = false
    @State private var isSettingsShowing = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View{
        TabView(selection: $selectedTab) {
            // Tabs are my pages, use them hoes
            Tab(value: 0){
                GoalsView(selectedTab: $selectedTab)
            }
            
            Tab(value: 1){
                GoalHistoryView()
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .blur(radius: isMenuShowing ? 8 : 0)
        .overlay(alignment: .bottom){
            BottomTabBar(selectedTab: $selectedTab, isSavignsGoalViewShowing: $isSavingGoalViewShowing)
                .padding(.horizontal)
                .offset(y: 20)
                .blur(radius: isMenuShowing ? 8 : 0)
        }
        .overlay(alignment: .topTrailing) {
            HamburgerButton(isMenuShowing: $isMenuShowing)
        }
        .overlay {
            if isMenuShowing {
                HamburgerOverlay(isMenuShowing: $isMenuShowing, isProfileShowing: $isProfileShowing, isSettingsShowing: $isSettingsShowing)
                        .transition(.opacity)
                }
        }
        .animation(.spring(), value: isMenuShowing)
        .sheet(isPresented: $isSavingGoalViewShowing) {
            NewGoalView(selectedTab: $selectedTab, isSavingsGoalViewShowing: $isSavingGoalViewShowing)
        }
        // sometimes tabs for everthing is kinda BS
        .sheet(isPresented: $isProfileShowing) {
            ProfileView()
        }
        .sheet(isPresented: $isSettingsShowing) {
            SettingsView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: SavingsGoal.self, inMemory: true)
}
