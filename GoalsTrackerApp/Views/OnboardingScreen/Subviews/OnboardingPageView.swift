//
//  OnboardingPageView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 27.02.2026.
//

import SwiftUI

struct OnboardingPageView: View {
    
    // MARK: - Properties
    let title: String
    let backgroundImageName: String

    // MARK: - Body
    var body: some View {
        ZStack {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            LinearGradient(colors: [.white.opacity(0.7), .black.opacity(0.1)], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()

            VStack() {
                Spacer()
                
                Text(title)
                    .font(.largeTitle).bold()
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 320)
            }
        }
    }
    
}
