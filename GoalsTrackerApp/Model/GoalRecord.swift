//
//  GoalRecord.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 24.02.2026.
//

import Foundation
import CoreData

@objc(GoalRecord)
final class GoalRecord: NSManagedObject {
    
    @NSManaged public var date: Date
    @NSManaged public var goal: Goal?
    
}

// MARK: - Fetch request
extension GoalRecord {
    
    class func fetchRequest() -> NSFetchRequest<GoalRecord> {
        let request = NSFetchRequest<GoalRecord>(entityName: "Goal")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \GoalRecord.date, ascending: false)]
        return request
    }
    
}

// MARK: - Identifiable
extension GoalRecord: Identifiable { }
