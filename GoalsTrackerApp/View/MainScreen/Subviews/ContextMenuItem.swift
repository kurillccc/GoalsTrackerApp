//
//  ContextMenuItem.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 04.03.2026.
//

import SwiftUI

struct ContextMenuItem: View {
    
    @ObservedObject var goal: Goal
    @ObservedObject var vm: GoalsViewModel
    
    var body: some View {
        Button {
            vm.pinGoal(goal)
        } label: {
            Label(
                (goal.isPinned ? "Открепить" : "Закрепить"),
                systemImage: "pin"
            )
        }
        
        Button(role: .destructive) {
            vm.deleteGoal(goal)
        } label: {
            Label("Удалить", systemImage: "trash")
        }
    }
    
}
