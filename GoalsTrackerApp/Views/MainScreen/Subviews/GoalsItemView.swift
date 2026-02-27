//
//  GoalsItemView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 24.02.2026.
//

import SwiftUI
import CoreData

struct GoalsItemView: View {
    
    // MARK: - Properties
    @ObservedObject var goal: Goal
    
    // MARK: - Body
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(goal.customColor.color)
                    .cornerRadius(16)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 30) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 40, height: 40)
                        Text(goal.icon)
                            .font(.system(size: 18))
                            .frame(width: 40, height: 40, alignment: .center)
                            .accessibilityLabel(Text(goal.title))
                    }

                    Text(goal.title)
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            }
            
            HStack {
                Text("0 дней")
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 34, height: 34)
                        .background(
                            Circle()
                                .fill(Color.green)
                        )
                        .accessibilityLabel("Добавить день")
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1.2, contentMode: .fill)
        .padding(4)
        .cornerRadius(16)
    }
    
}
