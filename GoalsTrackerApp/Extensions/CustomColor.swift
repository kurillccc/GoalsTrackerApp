//
//  CustomColor.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 24.02.2026.
//

import Foundation
import SwiftUI

enum CustomColor: String, CaseIterable {
    
    case blue
    case green
    case orange
    case pink
    case red
    case gray
    case clear
    
    var uiColor: UIColor {
        switch self {
        case .blue: return UIColor(named: "bgBlue") ?? .systemBlue
        case .green: return UIColor(named: "bgGreen") ?? .systemGreen
        case .orange: return UIColor(named: "bgOrange") ?? .systemOrange
        case .pink: return UIColor(named: "bgPink") ?? .systemPink
        case .red: return UIColor(named: "bgRed") ?? .systemRed
        case .gray: return UIColor(named: "bgGray") ?? .gray
        case .clear: return .clear
        }
    }
    
    var color: Color {
        Color(uiColor)
    }
    
}
