//
//  File.swift
//  
//
//  Created by Raffaele Cerullo on 25/07/2021.
//

import XCTest
import Combine
@testable import Network

final class NetworkClientTests: XCTestCase {

    private var sut: NetworkClient!
    private var session: URLSession!
    private let mockURL = URL(string: "http://www.google.com/")!
    private var mockEndpoint: Endpoint {
        Endpoint(baseURL: mockURL, path: "test", parameters: nil, method: .get)
    }
    private var validResponse: HTTPURLResponse? {
        HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil)
    }
    private var invalidResponse: HTTPURLResponse? {
        HTTPURLResponse(url: mockURL, statusCode: 300, httpVersion: nil, headerFields: nil)
    }
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        sut = NetworkClient(session: session)
    }

    override func tearDownWithError() throws {
        sut = nil
        session = nil
        MockURLProtocol.response = nil
        MockURLProtocol.error = nil
        cancellables.forEach { $0.cancel() }
        cancellables = []
        try super.tearDownWithError()
    }
    
    func test_request_success() {
        
        var resultResponse: NetworkResponse?
        
        let expectation = XCTestExpectation(description: "success response")
        
        MockURLProtocol.response = validResponse
        sut.request(endpoint: mockEndpoint).sink { completion in
            switch completion {
            case.failure(_):
                XCTFail("Shouldn't receive failure")
            case.finished:
                break
            }
        } receiveValue: { response in
            resultResponse = response
            expectation.fulfill()
        }.store(in: &cancellables)

        wait(for: [expectation], timeout: 0.1)
        
        XCTAssertEqual(resultResponse?.statusCode, 200)
    }
    
    func test_request_failure_status_code() {
        
        var resultError: NetworkError?
        
        let expectation = XCTestExpectation(description: "failure response")
        
        MockURLProtocol.response = invalidResponse
        
        sut.request(endpoint: mockEndpoint).sink { completion in
            switch completion {
            case.failure(let error):
                resultError = error
                expectation.fulfill()
            case.finished:
                XCTFail("Shouldn't receive finished")
            }
        } receiveValue: { response in
            XCTFail("Shouldn't receive response")
            
        }.store(in: &cancellables)

        wait(for: [expectation], timeout: 0.1)
                
        XCTAssertEqual(resultError, .endpointError(NetworkResponse(statusCode: 300, payload: Data())))
    }
    
    func test_request_failure_error() {
        
        var resultError: NetworkError?
        
        let expectation = XCTestExpectation(description: "failure response")
        
        let expectedError = NSError(domain: "domain", code: 303, userInfo: nil)
        MockURLProtocol.error = expectedError
        
        sut.request(endpoint: mockEndpoint).sink { completion in
            switch completion {
            case.failure(let error):
                resultError = error
                expectation.fulfill()
            case.finished:
                XCTFail("Shouldn't receive finished")
            }
        } receiveValue: { response in
            XCTFail("Shouldn't receive response")
            
        }.store(in: &cancellables)

        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(resultError, .unknown(expectedError))
    }
}
