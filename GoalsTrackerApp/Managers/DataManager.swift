//
//  DataManager.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 03.03.2026.
//

import Foundation
import CoreData

typealias DataManagerProtocol = GoalDataManagerProtocol & GoalRecordDataManagerProtocol

final class DataManager {
    
    static let shared = DataManager()
    
    let persistenceController: PersistenceController
    var context: NSManagedObjectContext {
        persistenceController.container
        .viewContext }
    
    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
    }
    
}
