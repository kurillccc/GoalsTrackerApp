//
//  OnbordingView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 25.02.2026.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var selection: Int = 0
    @AppStorage("hasOnboarded") private var hasOnboarded: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            TabView(selection: $selection) {
                OnboardingPageView(
                    title: "Ваши цели — ваши правила",
                    tint: .white,
                    backgroundImageName: "onboarding_bg_1"
                )
                .tag(0)

                OnboardingPageView(
                    title: "Хочешь отслеживать сериалы, сон или мемы? Без проблем.",
                    tint: .white,
                    backgroundImageName: "onboarding_bg_2"
                )
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))

            VStack(spacing: 12) {
                Button(selection == 1 ? "Приступим)" : "Согласен!") {
                    withAnimation {
                        if selection < 1 {
                            selection = 1
                        } else {
                            hasOnboarded = true
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .padding(.top, 12)
    }
    
}

struct OnboardingPageView: View {
    
    let title: String
    let tint: Color
    let backgroundImageName: String

    var body: some View {
        ZStack {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            LinearGradient(colors: [.black.opacity(0.35), .black.opacity(0.1)], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer(minLength: 10)

                VStack(spacing: 10) {
                    Text(title)
                        .font(.title).bold()
                        .foregroundStyle(tint)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }

                Spacer(minLength: 10)
            }
            .padding()
        }
    }
    
}

#Preview {
    OnboardingView()
}
