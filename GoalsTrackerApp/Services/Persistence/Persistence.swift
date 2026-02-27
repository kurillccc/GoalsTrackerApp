//
//  Persistence.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 23.02.2026.
//

import CoreData
import SwiftUI

struct PersistenceController {
    
    // MARK: - Properties
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        for i in 0..<5 {
            let goal = Goal(context: viewContext)
            goal.id = UUID()
            goal.icon = ["🏃‍♂️", "🧑‍💻", "📚", "🍏", "🍩"][i]
            goal.color = ["yellow", "blue", "green", "orange", "pink", "red"][i]
            goal.title = ["Jogging", "Project", "Reading", "Eat Healthy", "Avoid Sugar"][i]
            goal.position = Int16(i)
            goal.addedOn = Date()
            goal.modifiedOn = Date()
            goal.isRemoved = false
        }
        
        do {
            try viewContext.save()
            print("✅ Preview data saved successfully")
        } catch {
            print("❌ Preview save error: \(error)")
        }
        
        return controller
    }()
    
    let container: NSPersistentContainer
    
    // MARK: - Init
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "GoalsTrackerApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
}
