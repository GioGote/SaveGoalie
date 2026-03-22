//
//  NewGoalView.swift
//  SaveGoalie
//
//

import SwiftUI
import SwiftData

struct NewGoalView: View {
    var selectedTab: Binding<Int>
    var isSavingsGoalViewShowing: Binding<Bool>
    @Environment(\.modelContext) private var modelContext
    @State private var title = ""
    @State private var targetAmount = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("New Goal")
                .font(.largeTitle)
                .fontWeight(.bold)
                .offset(y: 25)

            Spacer()

            VStack(alignment: .leading, spacing: 6) {
                Text("Goal Name:")
                    .padding(.horizontal)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.accent)

                TextField("e.g. New Computer", text: $title)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 30)
                    .frame(height: 65)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(1), lineWidth: 2)
                            .padding(.horizontal)
                    )
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Goal Amount:")
                    .padding(.horizontal)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.accent)

                TextField("e.g. $2000.00", text: $targetAmount)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 30)
                    .frame(height: 65)
                    .keyboardType(.decimalPad)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(1), lineWidth: 2)
                            .padding(.horizontal)
                    )
            }

            Button {
                guard !title.isEmpty, let amount = Double(targetAmount), amount > 0 else { return }
                let newGoal = SavingsGoal(title: title, targetAmount: amount)
                modelContext.insert(newGoal)

                title = ""
                targetAmount = ""
                selectedTab.wrappedValue = 0
                isSavingsGoalViewShowing.wrappedValue = false
            } label: {
                Text("Save Goal")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.accent)
                            .padding(.horizontal)
                    )
            }

            Spacer()
            
            Button {
                isSavingsGoalViewShowing.wrappedValue = false
            } label: {
                Image(systemName: "plus.circle")
                    .font(.title)
                    .rotationEffect(.degrees(45))
            }
            .frame(maxWidth: .infinity)
            .padding()
            
        }
    }
}

#Preview {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            NewGoalView(selectedTab: .constant(0), isSavingsGoalViewShowing: .constant(true))
                .modelContainer(for: SavingsGoal.self, inMemory: true)
        }
}
