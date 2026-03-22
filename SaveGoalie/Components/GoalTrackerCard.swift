//
//  GoalTrackerCard.swift
//  SaveGoalie
//
//

import SwiftUI
import SwiftData


struct GoalTrackerCard: View {
    // var selectedTab: Binding<Int>
    @Bindable var goal: SavingsGoal
    var onDelete: () -> Void
    @Environment(\.modelContext) private var modelContext
    @State private var isExpanded = false
    @State private var depositAmount = ""
    @State private var showDeleteConfirmation = false

    var progress: Double {
        guard goal.targetAmount > 0 else { return 0 }
        return min(goal.currentAmount / goal.targetAmount, 1.0) // caps at 100%
    }

    var isComplete: Bool {
        goal.currentAmount >= goal.targetAmount
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Button {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
            } label: {
                VStack(alignment: .leading, spacing: 8) {

                    HStack {
                        Text(goal.title)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.accent)
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }

                    // Progress Bar
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.systemGray5))
                                .frame(height: 10)

                            RoundedRectangle(cornerRadius: 8)
                                .fill(isComplete ? .green : .accentColor)
                                .frame(width: max(geo.size.width * progress, 0.01), height: 10)
                                .animation(.spring(), value: progress)
                        }
                    }
                    .frame(height: 10)

                    HStack {
                        Text("$\(goal.currentAmount, specifier: "%.2f")")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                        Spacer()
                        Text(isComplete ? "Complete!" : "$\(goal.targetAmount, specifier: "%.2f")")
                            .font(.caption)
                            .foregroundColor(isComplete ? .green : .gray)
                            .fontWeight(.semibold)
                    }
                }
            }
            .buttonStyle(.plain)
            .padding(.top, 15)

            if isExpanded {
                Divider()

                VStack(spacing: 12) {

                    // Deposit input
                    HStack {
                        TextField("Amount", text: $depositAmount)
                            .keyboardType(.decimalPad)
                            .padding(.horizontal)
                            .frame(height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )

                        // Subtract
                        Button {
                            if let amount = Double(depositAmount) {
                                withAnimation {
                                    goal.currentAmount = max(0, goal.currentAmount - amount)
                                }
                                depositAmount = ""
                            }
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.red)
                        }

                        // Add
                        Button {
                            if let amount = Double(depositAmount) {
                                withAnimation {
                                    goal.currentAmount += amount
                                }
                                depositAmount = ""
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.accentColor)
                        }
                    }

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Remaining")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("$\(max(0, goal.targetAmount - goal.currentAmount), specifier: "%.2f")")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Progress")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("\(Int(progress * 100))%")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    // ── Delete Button ──
                    Button(role: .destructive) {
                        showDeleteConfirmation = true
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete Goal")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.red.opacity(0.1))
                        )
                        .foregroundColor(.red)
                    }
                    .confirmationDialog(
                        "Delete \(goal.title)?",
                        isPresented: $showDeleteConfirmation,
                        titleVisibility: .visible
                    ) {
                        Button("Delete", role: .destructive) {
                            withAnimation {
                                isExpanded = false
                                // selectedTab.wrappedValue = 0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                onDelete()
                            }
                        }
                        Button("Cancel", role: .cancel) { }
                    }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
        .padding(.horizontal)
    }
}
