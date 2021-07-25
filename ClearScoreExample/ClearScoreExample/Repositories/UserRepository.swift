//
//  UserRepository.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 21/07/2021.
//

import Foundation
import Network
import Combine

protocol UserRepositoryType {
    func fetchUser() -> AnyPublisher<User, UserRepositoryError>
}

enum UserRepositoryError: Error, Equatable {
    
    case networkError(_ error: Error)
    case mapError
    
    static func == (lhs: UserRepositoryError, rhs: UserRepositoryError) -> Bool {
        switch (lhs, rhs) {
        case (mapError, mapError):return true
        case (networkError(let lhsError), networkError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default: return false
        }
    }
}

struct UserRepository: UserRepositoryType {
    
    // MARK: - Private properties
    
    private let networkClient: NetworkClientType
    private let userMapper: UserMapperType
    
    private enum Path {
        static let creditValue = "/prod/mockcredit/values"
    }
    
    // MARK: - Public methods
    
    init(networkClient: NetworkClientType = NetworkClient(), userMapper: UserMapperType = UserMapper()) {
        self.networkClient = networkClient
        self.userMapper = userMapper
    }
    
    func fetchUser() -> AnyPublisher<User, UserRepositoryError> {
        let endpoint = Endpoint(baseURL: NetworkConfiguration.baseURL, path: Path.creditValue, parameters: nil, method: .get)
        return networkClient.request(endpoint: endpoint)
            .tryMap { response -> User  in
                guard let user = userMapper.map(body: response.payload) else {
                    throw UserRepositoryError.mapError
                }
                return user
            }
            .mapError { error in
                return error as? UserRepositoryError ?? UserRepositoryError.networkError(error)
            }
            .eraseToAnyPublisher()
    }
}
