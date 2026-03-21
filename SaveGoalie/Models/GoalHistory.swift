//
//  GoalHistory.swift
//  SaveGoalie
//
//

import SwiftData
import Foundation

@Model
class GoalHistory {
    var title: String
    var targetAmount: Double
    var dateStarted: Date
    var dateCompleted: Date
    
    init(title: String, targetAmount: Double, dateStarted: Date) {
        self.title = title
        self.targetAmount = targetAmount
        self.dateStarted = dateStarted
        self.dateCompleted = Date()
    }
    // var 'name': (return type) - i'm learning as I go, leave me alone lol
    var goalLengthDays: Int {
        Calendar.current.dateComponents([.day], from: dateStarted, to: dateCompleted).day ?? 0
    }
    
    var goalLengthWeeks: Int {
        Calendar.current.dateComponents([.weekOfYear], from: dateStarted, to: dateCompleted).weekOfYear ?? 0
    }
}
