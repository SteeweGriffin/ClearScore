//
//  MockUserRepository.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import Foundation
import Combine
@testable import ClearScoreExample

final class MockUserRepository: UserRepositoryType {
    
    private(set) var fetchUserCallsCount = 0
    private var result: Result<User, UserRepositoryError>
    
    init(result: Result<User, UserRepositoryError>) {
        self.result = result
    }
    
    func fetchUser() -> AnyPublisher<User, UserRepositoryError> {
        fetchUserCallsCount += 1
        return Result.Publisher(result).eraseToAnyPublisher()
    }
    
}
