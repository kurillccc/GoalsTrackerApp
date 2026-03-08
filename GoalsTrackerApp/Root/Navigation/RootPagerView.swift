//
//  RootPagerView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 07.03.2026.
//

import SwiftUI

struct RootPagerView: View {
    
    // MARK: - Properties
    @State private var selection = 0

    // MARK: - Body
    var body: some View {
        TabView(selection: $selection) {
            GoalsView()
                .tag(0)
                .tabItem { Label("Цели", systemImage: "record.circle.fill") }

            StatisticView()
                .tag(1)
                .tabItem { Label("Статистика", systemImage: "hare.fill") }
        }
        .background(
            Color.clear
                .ignoresSafeArea(edges: .bottom)
        )
    }
    
}
