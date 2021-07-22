//
//  CaseIterableLastUnknownTests.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import XCTest
@testable import ClearScoreExample

final class CaseIterableLastUnknownTests: XCTestCase {

    private struct Struct: Codable {
        var sut: Enum
        enum Enum: String, Codable, CaseIterableLastUnknown {
            case test = "TEST"
            case unknown
        }
        
    }
    
    func test_unknown() throws {
        let data = try! JSONSerialization.data(withJSONObject: ["sut": "no_result"], options: .prettyPrinted)
        let result = try? JSONDecoder().decode(Struct.self, from: data)
        XCTAssertEqual(result?.sut, .unknown)
    }
    
    func test_known() throws {
        let data = try! JSONSerialization.data(withJSONObject: ["sut": "TEST"], options: .prettyPrinted)
        let result = try? JSONDecoder().decode(Struct.self, from: data)
        XCTAssertEqual(result?.sut, .test)
    }

}
