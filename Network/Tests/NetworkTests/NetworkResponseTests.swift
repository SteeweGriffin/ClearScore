//
//  File.swift
//  
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import XCTest
@testable import Network

final class NetworkResponseTests: XCTestCase {
        
    func test_makeNetworkResponse() {
        let mockHTTPURLResponse = MockHTTPURLResponse(statusCode: 200)
        let mockData = "test".data(using: .utf8)!
        let expectedResult = NetworkResponse(statusCode: 200, payload: mockData)
        let result = NetworkResponse.makeNetworkResponse(with: mockHTTPURLResponse, data: mockData)
        
        XCTAssertEqual(result, expectedResult)
    }
    
    // MARK: - Private
    
    private class MockHTTPURLResponse: HTTPURLResponseType {
        var statusCode: Int
        
        init(statusCode: Int){
            self.statusCode = statusCode
        }
    }
}
