//
//  AddNewGoalView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 28.02.2026.
//

import SwiftUI

struct AddNewGoalView: View {
    
    // MARK: - Properties
    @StateObject private var vm = AddNewGoalViewModel()
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Введите название цели", text: $vm.title)
                }
                
                Section(header: Text("Эмодзи")) {
                    SelectEmojiView(vm: vm)
                }
                
                
                Section(header: Text("Цвета")) {
                    SelectColorView(vm: vm)
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color(.systemGray6))
            .safeAreaInset(edge: .bottom) {
                AddButtonView(vm: vm, onDismiss: {
                    dismiss()
                })
                .padding(.horizontal)
                .padding(.bottom, 8)
                .background(
                    Color(.systemGray6)
                        .ignoresSafeArea(edges: .bottom)
                )
            }
        }
    }
    
}
