//
//  MainRouterTests.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import XCTest
@testable import ClearScoreExample

final class MainRouterTests: XCTestCase {

    private var sut: MainRouter!
    private var navigation = MockNavigationController()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MainRouter(with: navigation)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_displayDashboard() throws {
        // WHEN
        sut.displayDashboard()
        
        // THEN
        XCTAssertEqual(navigation.setControllerAsRootCallsCount, 1)
        XCTAssertTrue(navigation.expectedController is ViewController)
    }
    
    func test_displayDetail() throws {
        // WHEN
        sut.displayDetail(User.mock)
        
        // THEN
        XCTAssertEqual(navigation.pushControllerCallsCount, 1)
        XCTAssertTrue(navigation.expectedController is ViewController)
    }
    
    func test_displayError() throws {
        // WHEN
        sut.displayError("error message")
        
        let alertController = navigation.expectedController as? UIAlertController
        let action = alertController?.actions.first
        
        // THEN
        XCTAssertEqual(navigation.presentControllerCallsCount, 1)
        XCTAssertNotNil(alertController)
        XCTAssertEqual(alertController?.message, "error message")
        XCTAssertEqual(alertController?.title, "OPS!")
        XCTAssertNotNil(action)
        XCTAssertEqual(action?.title, "OK")

    }

}

