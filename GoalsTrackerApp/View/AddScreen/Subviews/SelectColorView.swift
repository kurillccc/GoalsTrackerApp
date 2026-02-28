//
//  SelectColorView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 28.02.2026.
//

import SwiftUI

struct SelectColorView: View {
    
    // MARK: - Properties
    @ObservedObject var vm: AddNewGoalViewModel
    
    // MARK: - Layout Constants
    let columns = [GridItem(.adaptive(minimum: 45, maximum: 55), spacing: 10)]
    
    // MARK: - Body
    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(vm.colors, id: \.self) { color in
                Button {
                    vm.color = color
                } label: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(color.color)
                        .frame(width: 45, height: 45)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(
                                    vm.color == color ?
                                    color.color.opacity(0.3):
                                    Color.clear, lineWidth: 3
                                       )
                                .frame(width: 55, height: 55)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 5)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
    }
    
}
