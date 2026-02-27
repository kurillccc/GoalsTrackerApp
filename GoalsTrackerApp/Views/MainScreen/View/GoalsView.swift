//
//  ContentView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 23.02.2026.
//

import SwiftUI
import CoreData

struct GoalsView: View {
    
    // MARK: - Properties
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Goal.position, ascending: true)],
        predicate: NSPredicate(format: "isRemoved == false"),
        animation: .default
    ) private var goals: FetchedResults<Goal>
    
    @State private var showingAddNew = false
    
    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 160), spacing: 10.0)]
    }
    
    private var addNewButton: some View {
        Button {
            showingAddNew = true
        } label: {
            Text("New")
        }
    }
        
    // MARK: - Body
    var body: some View {
        NavigationView {
            Group {
                if goals.isEmpty {
                    Text("No goals yet!")
                } else {
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
            .navigationTitle(Text("Goals"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addNewButton
                }
            }
        }
    }
    
}
