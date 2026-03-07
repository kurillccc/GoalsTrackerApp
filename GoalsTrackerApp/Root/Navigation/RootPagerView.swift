//
//  RootPagerView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 07.03.2026.
//

import SwiftUI

struct RootPagerView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            GoalsView()
                .tag(0)
                .tabItem { Label("Цели", systemImage: "record.circle.fill") }

            StatusView()
                .tag(1)
                .tabItem { Label("Статистика", systemImage: "hare.fill") }
        }
    }
    
}
