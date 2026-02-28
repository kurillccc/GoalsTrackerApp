//
//  GoalsEmptyView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 27.02.2026.
//

import SwiftUI

struct GoalsEmptyView: View {
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image(systemName: "flame.fill")
                .font(.system(size: 100))
                .foregroundColor(Color(.systemGray5))
                .fontWeight(.bold)
                
            Text("Что будем отслеживать?")
        }
    }
    
}

#Preview {
    GoalsEmptyView()
}
