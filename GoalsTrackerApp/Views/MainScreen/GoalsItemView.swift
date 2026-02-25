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
            Text(goal.icon)
                .font(.system(size: 60))
            Text(goal.title)
                .font(.footnote)
                .foregroundColor(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1.0, contentMode: .fill)
        .padding(4)
        .background(Color.background)
        .cornerRadius(8.0)
        .shadow(color: .gray, radius: 3.0, x: 0.0, y: 0.0)
    }
    
}
