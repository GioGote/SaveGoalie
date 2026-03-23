//
//  SavingsGoal.swift
//  SaveGoalie
//
//

import SwiftData
import Foundation

@Model
class SavingsGoal {
    var title: String
    var targetAmount: Double
    var currentAmount: Double
    var createdAt: Date
    var completedAt: Date?
    var isComplete: Bool = false
    var transactions: [Transaction] = [] // an empty array of Transactions

    init(title: String, targetAmount: Double) {
        self.title = title
        self.targetAmount = targetAmount
        self.currentAmount = 0.0
        self.createdAt = Date()
    }

    var progress: Double {
        currentAmount / targetAmount
    }
    // ('_ amount: Double) provides an argument label so that the caller doesn't need to write the parameter name within the func call
    func deposit(_ amount: Double) {
        guard amount > 0 else { return }
        currentAmount += amount
        transactions.append(Transaction(amount: amount, type: .deposit))
        // Check if complete after every deposit
        checkCompletion()
    }

    func withdraw(_ amount: Double) {
        guard amount > 0 else { return }
        currentAmount = max(0, currentAmount - amount)
        transactions.append(Transaction(amount: amount, type: .withdrawal))
        isComplete = false  // incomplete if funds are removed
        completedAt = nil
    }

    private func checkCompletion() {
        if currentAmount >= targetAmount && !isComplete {
            isComplete = true
            completedAt = Date()
        }
    }
}

// Codable lets me do DB shenanigans with the Transaction array
struct Transaction: Codable {
    var amount: Double
    var date: Date
    var type: TransactionType
    
    init(amount: Double, type: TransactionType) {
        self.amount = amount
        self.date = Date()
        self.type = type
    }
}

enum TransactionType: Codable {
    case deposit
    case withdrawal
}
