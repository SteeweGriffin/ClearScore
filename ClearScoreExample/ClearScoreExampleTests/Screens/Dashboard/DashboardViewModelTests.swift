//
//  DashboardViewModelTests.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import XCTest
import Combine
@testable import ClearScoreExample

final class DashboardViewModelTests: XCTestCase {

    private var sut: DashboardViewModel!
    private var repository: MockUserRepository!
    private var successResult: Result<User, UserRepositoryError> = .success(User.mock)
    private var failureResult: Result<User, UserRepositoryError> = .failure(UserRepositoryError.mapError)
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = MockUserRepository(result: successResult)
        sut = DashboardViewModel(repository: repository)
    }

    override func tearDownWithError() throws {
        sut = nil
        repository = nil
        cancellables.forEach { $0.cancel() }
        cancellables = []
        try super.tearDownWithError()
    }
    
    func test_screenTitle() throws {
        XCTAssertEqual(sut.screenTitle, "Dashboard")
    }

    func test_fetchUser_success() throws {
        sut.fetchUser()
        
        var resultUser: User?
        var resultState: DashboardViewModelState?
        
        sut.statePublisher
            .sink { state in
                resultUser = self.sut.user
                resultState = state
            }
            .store(in : &cancellables)
        
        let viewModel = DashboardCircleViewModel(creditReportInfo: User.mock.creditReportInfo)
        XCTAssertEqual(resultState, DashboardViewModelState.dataAvailable(viewModel: viewModel))
        XCTAssertEqual(resultUser, User.mock)
    }
    
    func test_fetchUser_failure() throws {
        repository = MockUserRepository(result: failureResult)
        sut = DashboardViewModel(repository: repository)
        
        var resultUser: User?
        var resultState: DashboardViewModelState?
        
        sut.fetchUser()
        sut.statePublisher
            .sink { state in
                resultUser = self.sut.user
                resultState = state
            }
            .store(in : &cancellables)
        
        XCTAssertNil(resultUser)
        XCTAssertEqual(resultState, DashboardViewModelState.error(message: "The operation couldn’t be completed. (ClearScoreExample.UserRepositoryError error 1.)"))

    }
}
