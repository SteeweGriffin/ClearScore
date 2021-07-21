//
//  CaseIterableLastUnknown.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import Foundation

protocol CaseIterableLastUnknown: CaseIterable & RawRepresentable where RawValue: Codable, AllCases: BidirectionalCollection { }

extension CaseIterableLastUnknown {
    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.allCases.last!
    }
}
