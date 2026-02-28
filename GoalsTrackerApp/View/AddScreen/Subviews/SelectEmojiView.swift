//
//  SelectEmojiView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 28.02.2026.
//

import SwiftUI

struct SelectEmojiView: View {
    
    // MARK: - Properties
    @ObservedObject var vm: AddNewGoalViewModel
    
    // MARK: - Layout Constants
    let columns = [GridItem(.adaptive(minimum: 45, maximum: 55), spacing: 10)]
    
    // MARK: - Body
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(vm.icons, id: \.self) { icon in
                Button {
                    vm.icon = icon
                } label: {
                    Text(icon)
                        .font(.system(size: 35))
                        .frame(width: 55, height: 55)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(vm.icon == icon ? Color.gray.opacity(0.25) : Color.clear)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 5)
    }
    
}
