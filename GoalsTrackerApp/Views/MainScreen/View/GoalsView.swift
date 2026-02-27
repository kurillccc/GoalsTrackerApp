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
    
    @State private var searchText = ""
    
    var filteredGoals: [Goal] {
        if searchText.isEmpty {
            return Array(goals)
        } else {
            return goals.filter { goal in
                goal.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    @State private var showingAddNew = false
    
    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 150, maximum: 200), spacing: 10.0)]
    }
    
    private var addNewButton: some View {
        Button {
            showingAddNew = true
        } label: {
            Image(systemName: "plus")
        }
    }
        
    // MARK: - Body
    var body: some View {
        NavigationView {
            Group {
                if goals.isEmpty {
                    GoalsEmptyView()
                } else if filteredGoals.isEmpty && !searchText.isEmpty {
                    ContentUnavailableView("Ничего не найдено", systemImage: "magnifyingglass")
                        .padding()
                } else {
                    GoalsGridView(goals: filteredGoals, columns: columns)
                }
            }
            .navigationTitle(Text("Цели"))
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Поиск"
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    addNewButton
                }
            }
        }
    }
    
}
