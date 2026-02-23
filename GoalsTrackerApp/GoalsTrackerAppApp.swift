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
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
