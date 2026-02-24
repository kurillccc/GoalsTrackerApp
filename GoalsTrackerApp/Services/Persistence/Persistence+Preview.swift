//
//  Persistence+Preview.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 24.02.2026.
//

import Foundation
import CoreData

extension PersistenceController {
    
    static func addPreviewData(context: NSManagedObjectContext) {
        addGoal(icon: "🏃‍♂️", title: "Jogging", position: 0, isCompletedToday: true, context: context)
        addGoal(icon: "🧑‍💻", title: "Project", position: 1, isCompletedToday: false, context: context)
        addGoal(icon: "📚", title: "Reading", position: 2, isCompletedToday: false, context: context)
        addGoal(icon: "🍏", title: "Eat Healthy", position: 3, isCompletedToday: true, context: context)
        addGoal(icon: "🍩", title: "Avoid Sugar", position: 4, isCompletedToday: true, context: context)
    }
    
    static func addGoal(icon: String, title: String, position: Int16, isCompletedToday: Bool, context: NSManagedObjectContext) {
        let goal = Goal(context: context)
        goal.id = UUID()
        goal.icon = icon
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
