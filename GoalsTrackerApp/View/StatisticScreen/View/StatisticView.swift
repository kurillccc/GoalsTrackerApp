//
//  StatisticView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 07.03.2026.
//

import SwiftUI

struct StatisticView: View {
    
    @StateObject private var viewModel = StatusViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                if false {
                    StatisticEmptyView()
                } else {
                    VStack(alignment: .center, spacing: 20) {
                        StatisticItiemView(countOfDays: viewModel.bestStreakDays, title: "Лучший период")
                        StatisticItiemView(countOfDays: viewModel.perfectDays, title: "Идеальные дни")
                        StatisticItiemView(countOfDays: viewModel.trackersCompleted, title: "Трекеров завершено")
                        StatisticItiemView(countOfDays: viewModel.averageValue, title: "Среднее значение")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.top, 30)
                    .padding(.horizontal, 16)
                }
            }
            .task {
                await viewModel.load()
            }
            .navigationTitle("Статистика")
        }
    }
    
}

#Preview {
    StatisticView()
}
