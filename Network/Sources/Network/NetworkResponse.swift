//
//  File.swift
//  
//
//  Created by Raffaele Cerullo on 20/07/2021.
//

import Foundation

public struct NetworkResponse: Equatable {
    public let statusCode: Int
    public let payload: Data
}

public extension NetworkResponse {
    static func makeNetworkResponse(with urlResponse: HTTPURLResponseType, data: Data) ->  NetworkResponse {
        return NetworkResponse(statusCode: urlResponse.statusCode, payload: data)
    }
}
