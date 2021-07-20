//
//  File.swift
//  
//
//  Created by Raffaele Cerullo on 20/07/2021.
//

import Foundation
import Combine

public protocol NetworkClientProtocol: AnyObject {
    func request(endPoint: EndpointType) -> AnyPublisher<NetworkResponse, NetworkError>
}

public final class NetworkClient: NetworkClientProtocol {

    // MARK: - Private properties

    private let urlSession: URLSessionProtocol

    private enum StatusCode {
        static let error = 300
    }

    // MARK: - Public methods

    public init(session: URLSessionProtocol = URLSession.shared) {
        urlSession = session
    }

    public func request(endPoint: EndpointType) -> AnyPublisher<NetworkResponse, NetworkError> {
        guard let request = endPoint.makeRequest() else {
            return AnyPublisher(Fail<NetworkResponse, NetworkError>(error: NetworkError.unavailablePath))
        }
        return urlSession.dataTaskPublisherWith(request: request)
            .tryMap { (data, response) in
                guard let urlResponse = response as? HTTPURLResponseProtocol else {
                    throw NetworkError.unvailableResponse
                }
                let networkResponse = NetworkResponse.makeNetworkResponse(with: urlResponse, data: data)
                if urlResponse.statusCode >= StatusCode.error {
                    throw NetworkError.endpointError(networkResponse)
                }
                return networkResponse
            }
            .mapError{ error in
                if let myError = error as? NetworkError {
                    return myError
                } else {
                    return NetworkError.unknown(error)
                }
                
            }
           .eraseToAnyPublisher()
    }
}

struct MyClass: Decodable {
    
}
