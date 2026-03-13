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
    @StateObject private var viewModel = GoalsViewModel()
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Goal.isPinned, ascending: false),
            NSSortDescriptor(keyPath: \Goal.position, ascending: true)
        ],
        predicate: NSPredicate(format: "isRemoved == false"),
        animation: .default
    ) private var goals: FetchedResults<Goal>
    
    @State private var searchText = ""
    @State private var showingAddNew = false
    
    // MARK: - Computed Properties
    var filteredGoals: [Goal] {
        if searchText.isEmpty {
            return Array(goals)
        } else {
            return goals.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 150, maximum: 200), spacing: 10.0)]
    }
    
    // MARK: - View Components
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
                    ContentUnavailableView("emptyGoalsStubViewText", systemImage: "flame.fill")
                } else if filteredGoals.isEmpty && !searchText.isEmpty {
                    ContentUnavailableView("emptySearchGoal", systemImage: "magnifyingglass")
                        .padding()
                } else {
                    GoalsGridView(vm: viewModel, goals: filteredGoals, columns: columns)
                }
            }
            .navigationTitle("goalsTitle")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "searchGoal"
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    addNewButton
                }
            }
            .sheet(isPresented: $showingAddNew) {
                AddNewGoalView()
                    .presentationDragIndicator(.visible)
            }
        }
    }
    
}
