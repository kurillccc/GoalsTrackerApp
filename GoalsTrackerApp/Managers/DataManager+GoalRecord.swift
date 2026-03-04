//
//  DataManager+GoalRecord.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 03.03.2026.
//

import Foundation
import CoreData

// MARK: - Protocols
protocol GoalRecordDataManagerProtocol {
    
    func createGoalRecord(for goalID: UUID, date: Date)
    func readGoalRecord(for goalID: UUID, date: Date) -> GoalRecord?
    func deleteGoalRecord(for goalID: UUID, date: Date)
    
}

extension GoalRecordDataManagerProtocol {
    
    func createGoalRecord(for goalID: UUID, date: Date = Date()) {
        createGoalRecord(for: goalID, date: date)
    }
    func readGoalRecord(for goalID: UUID, date: Date = Date()) -> GoalRecord? {
        readGoalRecord(for: goalID, date: date)
    }
    func deleteGoalRecord(for goalID: UUID, date: Date = Date()) {
        deleteGoalRecord(for: goalID, date: date)
    }
    
}

// MARK: - GoalRecordDataManagerProtocol
extension DataManager: GoalRecordDataManagerProtocol {
    
    func createGoalRecord(for goalID: UUID, date: Date) {
        context.performAndWait {
            guard let goal = readGoal(id: goalID) else { return }
            let goalRecord = GoalRecord(context: context)
            goalRecord.goal = goal
            goalRecord.date = date
            do {
                try context.save()
            } catch {
                fatalError("error: \(error)")
            }
            
        }
    }
    
    func readGoalRecord(for goalID: UUID, date: Date) -> GoalRecord? {
        var goalRecord: GoalRecord?
        context.performAndWait {
            let request: NSFetchRequest<GoalRecord> = GoalRecord.fetchRequest()
            var predicates: [NSPredicate] = []
            
            if let predicate = request.predicate {
                predicates.append(predicate)
            }
            
            let calendar = Calendar.current
            let startDate = calendar.startOfDay(for: date)
            guard let endDate = calendar.date(byAdding: .day, value: 1, to: startDate) else {
                fatalError("Failed to create end date for range")
            }
            
            predicates.append(
                NSPredicate(
                    format: "goal.id = %@ AND date >= %@ AND date < %@",
                    argumentArray: [
                        goalID,
                        startDate,
                        endDate
                    ]
                )
            )
            request.predicate = NSCompoundPredicate(
                andPredicateWithSubpredicates: predicates
            )
            request.fetchLimit = 1
            
            do {
                goalRecord = try context.fetch(request).first
            } catch {
                fatalError("error: \(error)")
            }
        }
        return goalRecord
    }
    
    func deleteGoalRecord(for goalID: UUID, date: Date) {
        context.performAndWait {
            guard let goalRecord = readGoalRecord(for: goalID, date: date) else { return }
            
            while let goalRecord = readGoalRecord(for: goalID, date: date) {
                context.delete(goalRecord)
            }
            
            guard context.hasChanges else { return }
            
            do {
                context.delete(goalRecord)
                try context.save()
            } catch {
                fatalError("error: \(error)")
            }
        }
    }
    
}
