//
//  Color.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import Foundation
import UIKit

enum Color: CaseIterable {
    case accent
    case textPrimary
    case textSecondary
    case background
}

extension Color {
    
    var uiColor: UIColor {
        switch self {
        case .accent: return UIColor(named: "AccentColor")!
        case .textPrimary: return UIColor(named: "TextPrimary")!
        case .textSecondary: return UIColor(named: "TextSecondary")!
        case .background: return UIColor(named: "BackgroundColor")!
        }
    }
}
