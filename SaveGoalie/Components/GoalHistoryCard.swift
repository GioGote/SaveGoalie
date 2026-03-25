//
//  GoalHistoryCard.swift
//  SaveGoalie
//
//

import SwiftUI
import SwiftData

struct GoalHistoryCard: View {
    let goal: SavingsGoal
    
    var sortedTransactions: [Transaction] {
        goal.transactions.sorted { $0.date > $1.date }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Text(goal.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.accent)
                Spacer()
                Text("\(goal.transactions.count) transactions")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.top, 15)
            
            Divider()
            
            if sortedTransactions.isEmpty {
                Text("No transactions yet")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 8)
            } else {
                VStack(spacing: 8) {
                    ForEach(sortedTransactions, id: \.date) { transaction in
                        TransactionRow(transaction: transaction)
                    }
                }
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

struct TransactionRow: View {
    let transaction: Transaction
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: transaction.date)
    }
    
    var isDeposit: Bool {
        transaction.type == .deposit
    }
    
    var body: some View {
        HStack {

            Image(systemName: isDeposit ? "arrow.down.circle.fill" : "arrow.up.circle.fill")
                .foregroundColor(isDeposit ? .green : .red)
                .font(.title3)
            
            // Date
            VStack(alignment: .leading, spacing: 2) {
                Text(isDeposit ? "Deposit" : "Withdrawal")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(isDeposit ? .green : .red)
                Text(formattedDate)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Amount
            Text("\(isDeposit ? "+" : "-")$\(transaction.amount, specifier: "%.2f")")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(isDeposit ? .green : .red)
        }
        .padding(.vertical, 4)
    }
}

#Preview("With Transactions") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SavingsGoal.self, configurations: config)

    let goal = SavingsGoal(title: "New Car", targetAmount: 5000)
    goal.deposit(500)
    goal.withdraw(100)
    goal.deposit(250)
    goal.deposit(1000)
    
    // won't show transactions made for seperate goals since these are all done at the same millisecond lol
    let macbook = SavingsGoal(title: "New Macbook", targetAmount: 5000)
    goal.deposit(500)
    goal.withdraw(100)
    goal.deposit(250)
    goal.deposit(1000)

    return ScrollView {
        VStack(spacing: 16) {
            GoalHistoryCard(goal: goal)
            GoalHistoryCard(goal: macbook)
        }
        .padding(.vertical)
    }
    .modelContainer(container)
}
