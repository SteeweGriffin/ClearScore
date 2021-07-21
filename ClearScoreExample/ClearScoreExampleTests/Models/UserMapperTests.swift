//
//  UserMapperTests.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import XCTest
@testable import ClearScoreExample

final class UserMapperTests: XCTestCase {

    private var sut: UserMapper!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UserMapper()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_map_success() throws {
        let result = sut.map(body: User.mock.data)
        XCTAssertNotNil(result)
    }

    func test_map_failure() throws {
        let result = sut.map(body: Data())
        XCTAssertNil(result)
    }
}
