//
//  ContextMenuItem.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 04.03.2026.
//

import SwiftUI

struct ContextMenuItem: View {
    
    let goal: Goal
    let vm: GoalsViewModel
    
    var body: some View {
        Button {
            vm.editGoal(goal)
        } label: {
            Label("Изменить", systemImage: "pencil")
        }
        
        Button(role: .destructive) {
            vm.deleteGoal(goal)
        } label: {
            Label("Удалить", systemImage: "trash")
        }
    }
    
}
