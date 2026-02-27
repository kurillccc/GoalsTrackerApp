//
//  OnboardingTabView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 27.02.2026.
//

import SwiftUI

struct OnboardingTabView: View {
    
    // MARK: - Properties
    @Binding var selection: Int
    
    // MARK: - Body
    var body: some View {
        TabView(selection: $selection) {
            OnboardingPageView(
                title: "Ваши цели — ваши правила",
                backgroundImageName: "onboarding_bg_1"
            )
            .tag(0)
            
            OnboardingPageView(
                title: "Хочешь отслеживать сериалы, сон или мемы? Без проблем.",
                backgroundImageName: "onboarding_bg_2"
            )
            .tag(1)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea()
        .disabled(selection == 0)
    }
    
}
