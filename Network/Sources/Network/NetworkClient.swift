//
//  File.swift
//  
//
//  Created by Raffaele Cerullo on 20/07/2021.
//

import Foundation
import Combine

public protocol NetworkClientType: AnyObject {
    func request(endPoint: EndpointType) -> AnyPublisher<NetworkResponse, NetworkError>
}

public final class NetworkClient: NetworkClientType {

    // MARK: - Private properties

    private let urlSession: URLSessionType

    private enum StatusCode {
        static let success = 0..<300
    }

    // MARK: - Public methods

    public init(session: URLSessionType = URLSession.shared) {
        urlSession = session
    }

    public func request(endPoint: EndpointType) -> AnyPublisher<NetworkResponse, NetworkError> {
        guard let request = endPoint.makeRequest() else {
            return AnyPublisher(Fail<NetworkResponse, NetworkError>(error: NetworkError.unavailablePath))
        }
        return urlSession.dataTaskPublisherWith(request: request)
            .tryMap { (data, response) in
                guard let urlResponse = response as? HTTPURLResponseType else {
                    throw NetworkError.unavailableResponse
                }
                let networkResponse = NetworkResponse.makeNetworkResponse(with: urlResponse, data: data)
                guard StatusCode.success ~= urlResponse.statusCode else {
                    throw NetworkError.endpointError(networkResponse)
                }
                return networkResponse
            }
            .mapError{ error in
                return error as? NetworkError ?? NetworkError.unknown(error)
            }
           .eraseToAnyPublisher()
    }
}
