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

    var body: some View {
        ScrollView {
            
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
                    .padding(.top, 250)

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
            .padding(.top, 20)
        }
    }
}
