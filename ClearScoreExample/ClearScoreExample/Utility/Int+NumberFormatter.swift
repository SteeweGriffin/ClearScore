//
//  Int+NumberFormatter.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import Foundation

extension Int {
    var GBP: String {
        let formatter = NumberFormatter()
        formatter.currencyCode = "GBP"
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
