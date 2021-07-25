//
//  MockNetworkClient.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import Foundation
import Combine
@testable import Network
@testable import ClearScoreExample

final class MockNetworkClient: NetworkClientType {

    private(set) var requestEndpointCallsCount = 0
    private(set) var cancelCallsCount = 0

    private var result: Result<NetworkResponse, NetworkError>

    init(result: Result<NetworkResponse, NetworkError>) {
        self.result = result
    }
    
    func request(endpoint: EndpointType) -> AnyPublisher<NetworkResponse, NetworkError> {
        requestEndpointCallsCount += 1
        return Result.Publisher(result).eraseToAnyPublisher()
    }
}
