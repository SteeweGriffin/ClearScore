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
        try super.tearDownWithError()
    }
    
    func test_screenTitle() throws {
        XCTAssertEqual(sut.screenTitle, "Dashboard")
    }

    func test_fetchUser_success() throws {
        sut.fetchUser()
        sut.fetchUser()
        sut.statePublisher
            .sink { state in
                let viewModel = DashboardCircleViewModel(creditReportInfo: User.mock.creditReportInfo)
                XCTAssertEqual(state, DashboardViewModelState.dataAvailable(viewModel: viewModel))
                XCTAssertEqual(self.sut.user, User.mock)
            }
            .store(in : &cancellables)
    }
    
    func test_fetchUser_failure() throws {
        repository = MockUserRepository(result: failureResult)
        sut = DashboardViewModel(repository: repository)
        
        sut.fetchUser()
        sut.statePublisher
            .sink { state in
                XCTAssertNil(self.sut.user)
                XCTAssertEqual(state, DashboardViewModelState.error(message: "The operation couldn’t be completed. (ClearScoreExample.UserRepositoryError error 1.)"))
            }
            .store(in : &cancellables)

    }
}
