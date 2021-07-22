//
//  DetailViewModelTests.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import XCTest
@testable import ClearScoreExample

final class DetailViewModelTests: XCTestCase {

    private var sut: DetailViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DetailViewModel(user: User.mock)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_screenTitle() throws {
        XCTAssertEqual(sut.screenTitle, "Detail")
    }
    
    func test_personaType() throws {
        XCTAssertEqual(sut.personaType.title, "Type")
        XCTAssertEqual(sut.personaType.value, "INEXPERIENCED")
    }
    
    func test_score() throws {
        XCTAssertEqual(sut.score.title, "Score")
        XCTAssertEqual(sut.score.value, "478")
    }
    
    func test_scoreBand() throws {
        XCTAssertEqual(sut.scoreBand.title, "Score Band")
        XCTAssertEqual(sut.scoreBand.value, "4")
    }
    
    func test_currentShortTermDebt() throws {
        XCTAssertEqual(sut.currentShortTermDebt.title, "Short term debt")
        XCTAssertEqual(sut.currentShortTermDebt.value, "£1,000.00")
    }
    
    func test_currentShortTermCreditLimit() throws {
        XCTAssertEqual(sut.currentShortTermCreditLimit.title, "Short term credit limit")
        XCTAssertEqual(sut.currentShortTermCreditLimit.value, "£2,000.00")
    }
    
    func test_currentLongTermDebt() throws {
        XCTAssertEqual(sut.currentLongTermDebt.title, "Long term debt")
        XCTAssertEqual(sut.currentLongTermDebt.value, "£3,000.00")
    }
    
    func test_daysUntilNextReport() throws {
        XCTAssertEqual(sut.daysUntilNextReport.title, "Days until next report")
        XCTAssertEqual(sut.daysUntilNextReport.value, "19")
    }
    
}
