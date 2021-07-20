//
//  File.swift
//  
//
//  Created by Raffaele Cerullo on 20/07/2021.
//

import XCTest
@testable import Network

final class EndPointTests: XCTestCase {

    private var sut: Endpoint!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_init() {
        // GIVEN
        let url = URL(string: "http://www.google.it")!
        let path = "/users"
        let parameters: [String: Any] = ["id": "0", "type": "test"]
        let data = "string".data(using: .utf8)

        // WHEN
        sut = Endpoint(baseURL: url, path: path, parameters: parameters, method: .get, body: data)

        // THEN
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.baseURL.absoluteString, "http://www.google.it")
        XCTAssertEqual(sut?.path, "/users")
        XCTAssertEqual(sut?.parameters?["id"] as? String, "0")
        XCTAssertEqual(sut?.parameters?["type"] as? String, "test")
        XCTAssertEqual(sut?.body, data)
        XCTAssertEqual(sut?.httpMethod, .get)
    }

    func test_init_with_URL() {
        // GIVEN
        let url = URL(string: "http://www.google.it/users?id=0&type=test")!
        let data = "string".data(using: .utf8)

        // WHEN
        sut = Endpoint(with: url, method: .get, body: data)

        // THEN
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.baseURL.absoluteString, "http://www.google.it")
        XCTAssertEqual(sut?.path, "/users")
        XCTAssertEqual(sut?.parameters?["id"] as? String, "0")
        XCTAssertEqual(sut?.parameters?["type"] as? String, "test")
        XCTAssertEqual(sut?.body, data)
        XCTAssertEqual(sut?.httpMethod, .get)
    }

    func test_makeRequest() {
        // GIVEN
        let url = URL(string: "http://www.google.it/users")!
        let data = "string".data(using: .utf8)
        sut = Endpoint(with: url, method: .get, body: data)

        // WHEN
        let request = sut.makeRequest()

        // THEN
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.url?.absoluteString, "http://www.google.it/users")
        XCTAssertEqual(request?.httpBody, data)
        XCTAssertEqual(request?.httpMethod, "GET")
        XCTAssertEqual(request?.timeoutInterval, 10)
    }

    func test_makeRequest_with_parameters() {
        // GIVEN
        let url = URL(string: "http://www.google.it")!
        let path = "/users"
        let parameters: [String: Any] = ["id": "0", "type": "test"]
        let data = "string".data(using: .utf8)
        sut = Endpoint(baseURL: url, path: path, parameters: parameters, method: .get, body: data)

        // WHEN
        let request = sut.makeRequest()

        // THEN
        let urlComponent = URLComponents(url: request!.url!, resolvingAgainstBaseURL: false)
        let queryItems = urlComponent?.queryItems?.reduce(into: [String: String?](), { (result, queryItem) in
            result[queryItem.name] = queryItem.value
        })
        XCTAssertEqual(urlComponent?.queryItems?.count, 2)
        XCTAssertEqual(queryItems?["id"], "0")
        XCTAssertEqual(queryItems?["type"], "test")
    }
}

