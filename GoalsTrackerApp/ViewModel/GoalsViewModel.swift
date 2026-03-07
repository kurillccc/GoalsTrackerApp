//
//  GoalsViewModel.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 03.03.2026.
//

import Foundation
internal import Combine

final class GoalsViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var showingAddNew: Bool = false
    @Published var goals: [Goal] = []
    @Published var editingGoal: Goal? = nil
    @Published var showingEdit: Bool = false
    
    // MARK: - Data Manager
    private let dataManager: DataManagerProtocol
    
    // MARK: - Init
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    // MARK: - Methods
    func markAsDone(_ goal: Goal) {
        dataManager.createGoalRecord(for: goal.id, date: Date())
    }
    
    func unmarkAsDone(_ goal: Goal) {
        dataManager.deleteGoalRecord(for: goal.id, date: Date())
    }
    
    func pinGoal(_ goal: Goal) {
        dataManager.pinGoal(id: goal.id)
    }

    func deleteGoal(_ goal: Goal) {
        dataManager.deleteGoal(id: goal.id)
    }
    
}
