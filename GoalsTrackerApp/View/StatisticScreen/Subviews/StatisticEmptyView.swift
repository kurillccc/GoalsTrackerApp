//
//  StatisticEmptyView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 07.03.2026.
//

import SwiftUI

struct StatisticEmptyView: View {
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("🥲")
                .font(.system(size: 100))
                .saturation(0)
                
            Text("emptyStatsStubViewText")
        }
    }
    
}
