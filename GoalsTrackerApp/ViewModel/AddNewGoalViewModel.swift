//
//  AddNewGoalViewModel.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 28.02.2026.
//

import Foundation
internal import Combine

final class AddNewGoalViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var title = ""
    @Published var icon: String
    @Published var color: CustomColor
    
    // MARK: - Data Manager
    private let dataManager: DataManagerProtocol
    
    // MARK: - Available Options
    let icons = GoalIcon.all
    let colors = CustomColor.allCases.filter { $0 != .clear }
    
    // MARK: - Init
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
        self.icon = ""
        self.color = CustomColor.clear
    }
    
    // MARK: - Computed Properties
    var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    // MARK: - Methods
    func save(completion: (_ success: Bool) -> Void) {
        var success = false
        defer { completion(success) }
        guard !title.isEmpty, icon != "", color != .clear else { return }
        dataManager.createGoal(title: title, icon: icon, color: color)
        success = true
    }
    
    func validate() -> Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !icon.isEmpty &&
        color != .clear
    }
    
}
