//
//  SavingsGoal.swift
//  SaveGoalie
//
//  Created by Gio Velasco on 3/16/26.
//

import SwiftData
import Foundation

@Model
class SavingsGoal {
    var title: String
    var targetAmount: Double
    var currentAmount: Double
    var createdAt: Date

    init(title: String, targetAmount: Double) {
        self.title = title
        self.targetAmount = targetAmount
        self.currentAmount = 0.0
        self.createdAt = Date()
    }

    var progress: Double {
        currentAmount / targetAmount
    }
}
