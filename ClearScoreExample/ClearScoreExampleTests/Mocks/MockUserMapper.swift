//
//  MockUserMapper.swift
//  ClearScoreExampleTests
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import Foundation
@testable import ClearScoreExample

final class MockUserMapper: UserMapperType {
    
    private(set) var mapCallsCount = 0
    private var result: User?
    
    init(result: User?) {
        self.result = result
    }
    
    func map(body: Data) -> User? {
        mapCallsCount += 1
        return result
    }
}
