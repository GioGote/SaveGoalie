//
//  GoalsView.swift
//  SaveGoalie
//
//

import SwiftUI
import SwiftData

struct GoalsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var goals: [SavingsGoal]
    var selectedTab: Binding<Int>

    var body: some View {
        ScrollView {
            // temporary debug — remove later
            Text("Goal count: \(goals.count)")
                .font(.caption)
                .foregroundColor(.gray)
            
            VStack(spacing: 16) {
                if goals.isEmpty {
                    
                    VStack(spacing: 12) {
                        Image(systemName: "basket")
                            .font(.system(size: 60))
                            .foregroundColor(.gray.opacity(0.5))

                        Text("No Goals Yet")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("Tap the + button below to create your first savings goal!")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 250) // pushes it toward center of screen

                } else {
                    ForEach(goals) { goal in
                        GoalTrackerCard(goal: goal) {
                            modelContext.delete(goal)
                        }
                    }
                }
            }
            .padding(.vertical)
            .padding(.bottom, 80)
        }
    }
}
/*
#Preview {
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SavingsGoal.self, configurations: config)
    
    let goals = [
        SavingsGoal(title: "New Computer", targetAmount: 1200),
        SavingsGoal(title: "Vacation", targetAmount: 3000),
        SavingsGoal(title: "Emergency Fund", targetAmount: 5000),
        SavingsGoal(title: "New Car", targetAmount: 15000)
    ]

    goals.forEach { container.mainContext.insert($0) }
    
    GoalsView(selectedTab: .constant(0))
        .modelContainer(container)
     
}
*/
