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
                
                VStack(alignment: .leading) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 28, height: 28)
                        Text(goal.icon)
                            .font(.system(size: 18))
                            .frame(alignment: .center)
                            .accessibilityLabel(Text(goal.title))
                    }
                    
                    Spacer()

                    Text(goal.title)
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.white)
                        .lineLimit(3)
                        .minimumScaleFactor(0.8)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 10)
                .padding(.leading)
            }
            
            HStack {
                Text("0 дней")
                    .font(.footnote.weight(.semibold))
                    .multilineTextAlignment(.leading)
                
                Spacer()
                                
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 34, height: 34)
                        .background(
                            Circle()
                                .fill(goal.customColor.color)
                        )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1.2, contentMode: .fill)
        .padding(4)
    }
    
}
