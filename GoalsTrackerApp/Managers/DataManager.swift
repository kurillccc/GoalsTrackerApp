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
    
}

typealias DataManagerProtocol = GoalDataManagerProtocol

// MARK: - DataManager
final class DataManager {
    
    static let shared = DataManager()
    
    private let persistenceController: PersistenceController
    private var context: NSManagedObjectContext {
        persistenceController.container
        .viewContext }
    
    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
    }
    
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
    
}
