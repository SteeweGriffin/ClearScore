//
//  File.swift
//  
//
//  Created by Raffaele Cerullo on 20/07/2021.
//

import Foundation

public enum NetworkError: Error {
    case unknown(Error)
    case unavailablePath
    case unavailableData
    case unavailableResponse
    case endpointError(NetworkResponse)
}

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (unknown(_), unknown(_)),
             (unavailablePath, unavailablePath),
             (unavailableData, unavailableData),
             (unavailableResponse, unavailableResponse):
            return true
        case (endpointError(let lhsNetworkResponse), endpointError(let rhsNetworkResposne)):
            return lhsNetworkResponse == rhsNetworkResposne
        default: return false
        }
    }
}

