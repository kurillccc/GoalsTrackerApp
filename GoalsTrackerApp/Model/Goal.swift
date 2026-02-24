//
//  Goal.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 23.02.2026.
//

import Foundation
import CoreData

@objc(Goal)
final class Goal: NSManagedObject {
    
    @NSManaged public var id: UUID
    @NSManaged public var icon: String
    @NSManaged public var title: String
    @NSManaged public var position: Int16
    @NSManaged public var addedOn: Date
    @NSManaged public var modifiedOn: Date
    @NSManaged public var isRemoved: Bool
    @NSManaged public var records: Set<GoalRecord>?
    
}

// MARK: - Fetch request
extension Goal {
    
    class func fetchRequest() -> NSFetchRequest<Goal> {
        let request = NSFetchRequest<Goal>(entityName: "Goal")
        request.predicate = NSPredicate(format: "isRemoved = false")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Goal.position, ascending: true)]
        return request
    }
    
}

// MARK: - Identifiable
extension Goal: Identifiable { }
