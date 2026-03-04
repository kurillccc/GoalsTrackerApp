//
//  DataManager.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 28.02.2026.
//

import Foundation
import CoreData

// MARK: - Protocols
protocol GoalDataManagerProtocol {
    
    func createGoal(title: String, icon: String, color: CustomColor)
    func readGoal(id: UUID) -> Goal?
    func deleteGoal(id: UUID)
    
}

// MARK: - GoalDataManagerProtocol
extension DataManager: GoalDataManagerProtocol {
    
    func createGoal(title: String, icon: String, color: CustomColor) {
        context.performAndWait {
            let request: NSFetchRequest<Goal> = Goal.fetchRequest()
            
            do {
                let goals = try context.fetch(request)
                for (index, goal) in goals.enumerated() {
                    goal.position = Int16(index + 1)
                }
                
                let goal = Goal(context: context)
                goal.id = UUID()
                goal.title = title
                goal.icon = icon
                goal.color = color.rawValue
                goal.position = 0
                goal.addedOn = Date()
                goal.modifiedOn = Date()
                
                try context.save()
            } catch {
                fatalError("error: \(error)")
            }
        }
    }
    
    func readGoal(id: UUID) -> Goal? {
        var goal: Goal?
        context.performAndWait {
            let request: NSFetchRequest<Goal> = Goal.fetchRequest()
            var predicates: [NSPredicate] = []
            
            if let predicate = request.predicate {
                predicates.append(predicate)
            }
            
            predicates.append(NSPredicate(format: "id = %@", argumentArray: [id]))
            request.predicate = NSCompoundPredicate(
                andPredicateWithSubpredicates: predicates
            )
            request.fetchLimit = 1
            
            do {
                goal = try context.fetch(request).first
            } catch {
                fatalError("error: \(error)")
            }
        }
        return goal
    }
    
    func deleteGoal(id: UUID) {
        context.performAndWait {
            let request: NSFetchRequest<Goal> = Goal.fetchRequest()
            request.predicate = NSPredicate(format: "id = %@", argumentArray: [id])
            request.fetchLimit = 1
            do {
                if let goal = try context.fetch(request).first {
                    context.delete(goal)
                    try context.save()
                }
            } catch {
                fatalError("error: \(error)")
            }
        }
    }
    
}
