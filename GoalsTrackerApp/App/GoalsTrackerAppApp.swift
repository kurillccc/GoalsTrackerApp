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
    @AppStorage("hasOnboarded") private var hasOnboarded: Bool = false
    
    // MARK: - Init
    init() {
#if DEBUG
        // UserDefaults.standard.set(false, forKey: "hasOnboarded")
        
        let context = persistenceController.container.viewContext
        let fetch = NSFetchRequest<Goal>(entityName: "Goal")
        if (try? context.count(for: fetch)) == 0 {
            PersistenceController.addPreviewData(context: context)
            try? context.save()
        }
#endif
    }
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            Group {
                if hasOnboarded {
                    GoalsView()
                        .transition(.opacity)
                } else {
                    OnboardingView()
                }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
