//
//  AddButtonView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 28.02.2026.
//

import SwiftUI

struct AddButtonView: View {
    
    // MARK: - Properties
    @ObservedObject var vm: AddNewGoalViewModel
    let onDismiss: () -> Void
    
    // MARK: - Body
    var body: some View {
        HStack {
            cancelButton
            
            createButton
        }
    }
    
    // MARK: - View Components
    private var cancelButton: some View {
        Button {
            onDismiss()
        } label: {
            Text("Отменить")
                .padding()
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(.red)
                )
        }
    }
    
    private var createButton: some View {
        Button {
            vm.save { result in
                if result {
                    onDismiss()
                }
            }
        } label: {
            Text("Создать")
                .bold()
                .padding()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.black)
                )
        }
    }
    
}
