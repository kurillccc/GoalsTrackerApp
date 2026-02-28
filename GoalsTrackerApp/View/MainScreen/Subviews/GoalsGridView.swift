//
//  GoalsGridView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 27.02.2026.
//

import SwiftUI
import CoreData

struct GoalsGridView: View {
    
    // MARK: - Properties
    let goals: [Goal]
    let columns: [GridItem]
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10.0) {
                ForEach(goals) { goal in
                    GoalsItemView(goal: goal)
                }
            }
            .padding(10)
        }
    }
    
}
