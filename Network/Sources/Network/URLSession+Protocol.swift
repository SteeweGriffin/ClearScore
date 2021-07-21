//
//  File.swift
//  
//
//  Created by Raffaele Cerullo on 20/07/2021.
//

import Foundation

public protocol URLSessionType: AnyObject {
    func dataTaskPublisherWith(request: URLRequest) -> URLSession.DataTaskPublisher
}

public protocol HTTPURLResponseType: AnyObject {
    var statusCode: Int { get }
}

extension URLSession: URLSessionType {
    public func dataTaskPublisherWith(request: URLRequest) -> URLSession.DataTaskPublisher {
        return dataTaskPublisher(for: request)
    }
}

extension HTTPURLResponse: HTTPURLResponseType {}

