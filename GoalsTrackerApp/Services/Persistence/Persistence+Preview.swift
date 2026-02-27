//
//  Persistence+Preview.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 24.02.2026.
//

import Foundation
import CoreData
import SwiftUI

extension PersistenceController {
    
    static func addPreviewData(context: NSManagedObjectContext) {
        addGoal(
            icon: "🏃‍♂️",
            color: .blue,
            title: "Jogging",
            position: 0,
            isCompletedToday: true,
            context: context
        )
        
        addGoal(
            icon: "📚",
            color: .green,
            title: "Reading",
            position: 2,
            isCompletedToday: false,
            context: context
        )
        
        addGoal(
            icon: "🍏",
            color: .orange,
            title: "Eat Healthy",
            position: 3,
            isCompletedToday: true,
            context: context
        )
        
        addGoal(
            icon: "🍩",
            color: .pink,
            title: "Avoid Sugar",
            position: 4,
            isCompletedToday: true,
            context: context
        )
        
        addGoal(
            icon: "💪",
            color: .red,
            title: "Workout",
            position: 5,
            isCompletedToday: false,
            context: context
        )
        
        addGoal(
            icon: "💧",
            color: .blue,
            title: "Drink Water",
            position: 6,
            isCompletedToday: true,
            context: context
        )
        
        addGoal(
            icon: "😴",
            color: .green,
            title: "Sleep 8 hours",
            position: 7,
            isCompletedToday: false,
            context: context
        )
    }
    
    static func addGoal(icon: String, color: CustomColor, title: String, position: Int16, isCompletedToday: Bool, context: NSManagedObjectContext) {
        let goal = Goal(context: context)
        goal.id = UUID()
        goal.icon = icon
        goal.color = color.rawValue
        goal.title = title
        goal.position = position
        goal.addedOn = Date()
        goal.modifiedOn = Date()
        goal.isRemoved = false
        var records = Set<GoalRecord>()
        for i in stride(from: isCompletedToday ? 0 : 1, through: 7, by: 2) {
            let goalRecord = GoalRecord(context: context)
            goalRecord.date = Date().addingTimeInterval(TimeInterval(-i * 86400))
            records.insert(goalRecord)
        }
        goal.records = records
    }
    
}
