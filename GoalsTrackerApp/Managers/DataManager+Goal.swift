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
    func pinGoal(id: UUID)
    
}

// MARK: - GoalDataManagerProtocol
extension DataManager: GoalDataManagerProtocol {
    
    func createGoal(title: String, icon: String, color: CustomColor) {
        context.performAndWait {
            let goal = Goal(context: context)
            goal.id = UUID()
            goal.title = title
            goal.icon = icon
            goal.color = color.rawValue
            goal.addedOn = Date()
            goal.modifiedOn = Date()
            goal.isPinned = false
            
            let request: NSFetchRequest<Goal> = Goal.fetchRequest()
            request.predicate = NSPredicate(format: "isPinned = NO")
            request.sortDescriptors = [NSSortDescriptor(key: "position", ascending: false)]
            request.fetchLimit = 1
            
            do {
                if let lastUnpinnedGoal = try context.fetch(request).first {
                    goal.position = lastUnpinnedGoal.position + 1
                } else {
                    let pinnedRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
                    pinnedRequest.predicate = NSPredicate(format: "isPinned = YES")
                    pinnedRequest.sortDescriptors = [NSSortDescriptor(key: "position", ascending: false)]
                    pinnedRequest.fetchLimit = 1
                    
                    if let lastPinnedGoal = try context.fetch(pinnedRequest).first {
                        goal.position = lastPinnedGoal.position + 1
                    } else {
                        goal.position = 0
                    }
                }
                
                goal.originalPosition = goal.position
                
                try context.save()
            } catch {
                fatalError("error creating goal: \(error)")
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
    
    func pinGoal(id: UUID) {
        context.performAndWait {
            let request: NSFetchRequest<Goal> = Goal.fetchRequest()
            request.predicate = NSPredicate(format: "id = %@", argumentArray: [id])
            request.fetchLimit = 1

            do {
                guard let goalToToggle = try context.fetch(request).first else { return }

                if goalToToggle.isPinned {
                    let pinnedFetch: NSFetchRequest<Goal> = Goal.fetchRequest()
                    pinnedFetch.predicate = NSPredicate(format: "isPinned == YES")
                    pinnedFetch.sortDescriptors = [NSSortDescriptor(key: "position", ascending: true)]
                    let pinnedGoals = try context.fetch(pinnedFetch)

                    let removedPosition = goalToToggle.position
                    for g in pinnedGoals where g != goalToToggle && g.position > removedPosition {
                        g.position -= 1
                    }

                    let targetUnpinnedPosition = goalToToggle.originalPosition

                    let unpinnedFetch: NSFetchRequest<Goal> = Goal.fetchRequest()
                    unpinnedFetch.predicate = NSPredicate(format: "isPinned == NO")
                    unpinnedFetch.sortDescriptors = [NSSortDescriptor(key: "position", ascending: true)]
                    let unpinnedGoals = try context.fetch(unpinnedFetch)

                    for g in unpinnedGoals where g.position >= targetUnpinnedPosition {
                        g.position += 1
                    }

                    goalToToggle.isPinned = false
                    goalToToggle.position = targetUnpinnedPosition

                } else {
                    goalToToggle.originalPosition = goalToToggle.position

                    let pinnedFetch: NSFetchRequest<Goal> = Goal.fetchRequest()
                    pinnedFetch.predicate = NSPredicate(format: "isPinned == YES")
                    pinnedFetch.sortDescriptors = [NSSortDescriptor(key: "position", ascending: true)]
                    let pinnedGoals = try context.fetch(pinnedFetch)

                    for g in pinnedGoals {
                        g.position += 1
                    }

                    goalToToggle.isPinned = true
                    goalToToggle.position = 0
                }

                try context.save()

                DispatchQueue.main.async {
                    NotificationCenter.default
                        .post(
                            name: NSNotification.Name.NSManagedObjectContextDidSave,
                            object: self.context
                        )
                }

            } catch {
                fatalError("error pinning/unpinning goal: \(error)")
            }
        }
    }
    
}
