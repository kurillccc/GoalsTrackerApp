//
//  CustomColor.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 24.02.2026.
//

import Foundation
import SwiftUI

enum CustomColor: String, CaseIterable {
    
    case yellow
    case blue
    case green
    case orange
    case pink
    case red
    
    var uiColor: UIColor {
        switch self {
        case .yellow: return UIColor(named: "bgYellow") ?? .systemYellow
        case .blue: return UIColor(named: "bgBlue") ?? .systemBlue
        case .green: return UIColor(named: "bgGreen") ?? .systemGreen
        case .orange: return UIColor(named: "bgOrange") ?? .systemOrange
        case .pink: return UIColor(named: "bgPink") ?? .systemPink
        case .red: return UIColor(named: "bgRed") ?? .systemRed
        }
    }
    
    var color: Color {
        Color(uiColor)
    }
    
}
