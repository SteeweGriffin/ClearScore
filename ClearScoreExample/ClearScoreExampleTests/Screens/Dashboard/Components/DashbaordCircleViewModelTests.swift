//
//  DashboardCircleViewModelTests.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import XCTest
@testable import ClearScoreExample

final class DashbaordCircleViewModelTests: XCTestCase {

    private var sut: DashbaordCircleViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DashbaordCircleViewModel(creditReportInfo: User.mock.creditReportInfo)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_properties() throws {
        XCTAssertEqual(sut.title, "Your credit score is")
        XCTAssertEqual(sut.subtitle, "out of 700")
        XCTAssertEqual(NSString(format: "%.01f", sut.valuePercentage), "0.7")
        XCTAssertEqual(sut.valueString, "478")
    }
}
