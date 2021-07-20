//
//  File.swift
//  
//
//  Created by Raffaele Cerullo on 20/07/2021.
//

import Foundation

public protocol URLSessionProtocol: AnyObject {
    func dataTaskPublisherWith(request: URLRequest) -> URLSession.DataTaskPublisher
}

public protocol HTTPURLResponseProtocol: AnyObject {
    var statusCode: Int { get }
}

extension URLSession: URLSessionProtocol {
    public func dataTaskPublisherWith(request: URLRequest) -> URLSession.DataTaskPublisher {
        return dataTaskPublisher(for: request)
    }
}

extension HTTPURLResponse: HTTPURLResponseProtocol {}

