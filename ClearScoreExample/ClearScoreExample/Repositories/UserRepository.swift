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
    func fetchUser() -> AnyPublisher<User, NetworkError>
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
    
    func fetchUser() -> AnyPublisher<User, NetworkError> {
        let endpoint = Endpoint(baseURL: NetworkConfiguration.baseURL, path: Path.creditValue, parameters: nil, method: .get)
        return networkClient.request(endPoint: endpoint)
            .tryMap { response -> User  in
                guard let user = userMapper.map(body: response.payload) else {
                    throw NetworkError.unavailableData
                }
                return user
            }
            .mapError { error in
                return error as? NetworkError ?? NetworkError.unknown(error)
            }
            .eraseToAnyPublisher()
    }
}
