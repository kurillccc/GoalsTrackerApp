//
//  StatisticItiemView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 07.03.2026.
//

import SwiftUI

struct StatisticItiemView: View {
    
    // MARK: - Placeholder Data
    var countOfDays: Int = 12
    var title: LocalizedStringKey
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                LinearGradient(
                                    colors: CustomColor.allCases
                                        .filter { $0 != .clear }
                                        .map { $0.color.opacity(0.7) },
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 4
                            )
                            .blur(radius: 6)
                        
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                LinearGradient(
                                    colors: CustomColor.allCases
                                        .filter { $0 != .clear }
                                        .map { $0.color },
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    }
                )
            
            VStack(alignment: .leading, spacing: 6) {
                Text("\(countOfDays)")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                Text(title)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }
            .padding(12)
        }
        .frame(height: 100)
    }
    
}
