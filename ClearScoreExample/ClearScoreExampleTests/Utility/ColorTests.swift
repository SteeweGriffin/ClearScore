//
//  ColorTests.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import XCTest
@testable import ClearScoreExample

final class ColorTests: XCTestCase {
        
    func test_colors() throws {
        Color.allCases.forEach { color in
            XCTAssertNotNil(color.uiColor)
        }
    }

}
