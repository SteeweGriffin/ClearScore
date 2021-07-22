//
//  UserRepositoryTests.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import XCTest
import Combine
@testable import Network
@testable import ClearScoreExample

final class UserRepositoryTests: XCTestCase {

    private var sut: UserRepository!
    private var networkClient: MockNetworkClient!
    private var successResult: Result<NetworkResponse, NetworkError> {
        .success(NetworkResponse(statusCode: 200, payload: User.mock.data))
    }
    private var userMapper: MockUserMapper!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkClient = MockNetworkClient(result: successResult)
        userMapper = MockUserMapper(result: User.mock)
        sut = UserRepository(networkClient: networkClient, userMapper: userMapper)
    }

    override func tearDownWithError() throws {
        sut = nil
        networkClient = nil
        userMapper = nil
        try super.tearDownWithError()
    }

    func test_fetchUser_success() throws {
        
        sut.fetchUser().sink(receiveCompletion: { completion in
            XCTAssertEqual(self.networkClient.requestEndpointCallsCount, 1)
            switch completion {
            case .failure(_):
                XCTFail("Shouldn't receive failure")
            case .finished:
                XCTAssertEqual(self.userMapper.mapCallsCount, 1)
            }
        }, receiveValue: { user in
            XCTAssertEqual(user, User.mock)
        }).store(in: &cancellables)
    }
    
    func test_fetchUser_failure_NetworkError() throws {
        
        networkClient = MockNetworkClient(result: .failure(NetworkError.unavailablePath))
        userMapper = MockUserMapper(result: User.mock)
        sut = UserRepository(networkClient: networkClient, userMapper: userMapper)
        
        sut.fetchUser().sink(receiveCompletion: { completion in
            XCTAssertEqual(self.networkClient.requestEndpointCallsCount, 1)
            switch completion {
            case .failure(let error):
                XCTAssertEqual(self.userMapper.mapCallsCount, 0)
                XCTAssertEqual(error, UserRepositoryError.networkError(NetworkError.unavailablePath))
            case .finished:
                XCTFail("Shouldn't receive finished")
            }
        }, receiveValue: { user in
            XCTFail("Shouldn't receive user")
        }).store(in: &cancellables)
    }
    
    func test_fetchUser_failure_UserMapper() throws {
        
        networkClient = MockNetworkClient(result: successResult)
        userMapper = MockUserMapper(result: nil)
        sut = UserRepository(networkClient: networkClient, userMapper: userMapper)
        
        sut.fetchUser().sink(receiveCompletion: { completion in
            XCTAssertEqual(self.networkClient.requestEndpointCallsCount, 1)
            switch completion {
            case .failure(let error):
                XCTAssertEqual(self.userMapper.mapCallsCount, 1)
                XCTAssertEqual(error, UserRepositoryError.mapError)
            case .finished:
                XCTFail("Shouldn't receive finished")
            }
        }, receiveValue: { user in
            XCTFail("Shouldn't receive user")
        }).store(in: &cancellables)
    }

}