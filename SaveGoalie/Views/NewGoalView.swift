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
    @FocusState private var focusedField: Field?

    enum Field { case title, amount }

    var isFormValid: Bool {
        !title.isEmpty && Double(targetAmount) != nil && Double(targetAmount)! > 0
    }

    var body: some View {
        VStack(spacing: 0) {

            // Drag indicator
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 12)
                .padding(.bottom, 24)

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("New Goal")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.accent)
                    Text("What are you saving towards?")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)

            // Fields
            VStack(spacing: 16) {
                GoalInputField(
                    label: "Goal Name",
                    placeholder: "e.g. New Computer",
                    icon: "star.fill",
                    text: $title,
                    keyboardType: .default,
                    isFocused: focusedField == .title
                )
                .focused($focusedField, equals: .title)

                GoalInputField(
                    label: "Target Amount",
                    placeholder: "e.g. 2000.00",
                    icon: "dollarsign",
                    text: $targetAmount,
                    keyboardType: .decimalPad,
                    isFocused: focusedField == .amount
                )
                .focused($focusedField, equals: .amount)
            }
            .padding(.horizontal, 24)

            Spacer()

            // Buttons
            VStack(spacing: 12) {
                Button {
                    guard isFormValid, let amount = Double(targetAmount) else { return }
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
                        .frame(height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(isFormValid ? Color.accentColor : Color.gray.opacity(0.3))
                        )
                        .animation(.easeInOut(duration: 0.2), value: isFormValid)
                }
                .disabled(!isFormValid)

                Button {
                    isSavingsGoalViewShowing.wrappedValue = false
                } label: {
                    Text("Cancel")
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .onTapGesture { focusedField = nil }
    }
}

struct GoalInputField: View {
    let label: String
    let placeholder: String
    let icon: String
    @Binding var text: String
    var keyboardType: UIKeyboardType
    var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .textCase(.uppercase)
                .tracking(0.8)

            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(isFocused ? .accentColor : .gray)
                    .frame(width: 20)
                    .animation(.easeInOut(duration: 0.2), value: isFocused)

                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 16)
            .frame(height: 54)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isFocused ? Color.accentColor : Color.clear, lineWidth: 2)
                    )
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused)
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
