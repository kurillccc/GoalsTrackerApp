//
//  GoalsTrackerAppApp.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 23.02.2026.
//

import SwiftUI
import CoreData

@main
struct GoalsTrackerAppApp: App {
    
    // MARK: - Properties
    let persistenceController = PersistenceController.shared
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            GoalsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
