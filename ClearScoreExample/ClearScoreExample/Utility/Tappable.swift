//
//  Tappable.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import Foundation

protocol Tappable {
    var tapAction: (() -> ())? { get set }
    var tapEnabled: Bool { get set }
}

extension Tappable {
    var tapAction: (() -> ())? {
        return {}
    }
    var tapEnabled: Bool { false }
}
