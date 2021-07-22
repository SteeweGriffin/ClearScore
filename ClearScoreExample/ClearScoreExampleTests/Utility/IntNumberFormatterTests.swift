//
//  IntNumberFormatterTests.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import XCTest
@testable import ClearScoreExample

final class IntNumberFormatterTests: XCTestCase {

    func test_GBP() throws {
        let sut: Int = 947373
        XCTAssertEqual(sut.GBP, "£947,373.00")
    }
}
