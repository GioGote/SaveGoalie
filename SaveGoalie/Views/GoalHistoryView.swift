//
//  GoalHistoryView.swift
//  SaveGoalie
//
//

import SwiftUI
import SwiftData

struct GoalHistoryView: View {
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

                        Text("No Goal History")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("Make Some Gosls and See How Far You've Come!")
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
