//
//  OnbordingView.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 25.02.2026.
//

import SwiftUI

struct OnboardingView: View {
    
    // MARK: - Properties
    @State private var isPressed: Bool = false
    @AppStorage("hasOnboarded") private var hasOnboarded: Bool = false
    
    @State private var currentPage = 0
    
    // MARK: - Body
    var body: some View {
        if hasOnboarded {
            GoalsView()
        } else {
            ZStack {
                OnboardingTabView(selection: $currentPage)
                
                VStack {
                    Spacer()
                    
                    HStack(spacing: 8) {
                        ForEach(0..<2, id: \.self) { index in
                            Circle()
                                .fill(index == currentPage ? Color.black : Color.black.opacity(0.3))
                                .frame(width: 8, height: 8)
                                .scaleEffect(index == currentPage ? 1.2 : 1.0)
                                .animation(.spring(), value: currentPage)
                        }
                    }
                    .padding(.bottom, 60)
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            if currentPage < 1 {
                                currentPage += 1
                            } else {
                                hasOnboarded = true
                            }
                        }
                    } label: {
                        Text("Приступим!")
                            .font(.system(size: 24, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .foregroundStyle(.white)
                    }
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
        }
    }
    
}

#Preview {
    OnboardingView()
}
