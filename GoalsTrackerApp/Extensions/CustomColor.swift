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
    case black
    
    var uiColor: UIColor {
        switch self {
        case .blue: return UIColor(named: "bgBlue") ?? .systemBlue
        case .green: return UIColor(named: "bgGreen") ?? .systemGreen
        case .orange: return UIColor(named: "bgOrange") ?? .systemOrange
        case .pink: return UIColor(named: "bgPink") ?? .systemPink
        case .red: return UIColor(named: "bgRed") ?? .systemRed
        case .black: return UIColor(named: "bgBlack") ?? .black
        }
    }
    
    var color: Color {
        Color(uiColor)
    }
    
}
