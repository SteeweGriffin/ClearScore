//
//  File.swift
//  
//
//  Created by Raffaele Cerullo on 20/07/2021.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public protocol EndpointType {
    var baseURL: URL! { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var httpMethod: HTTPMethod { get }
    var body: Data? { get }
    func makeRequest() -> URLRequest?
}

public struct Endpoint: EndpointType {
    public let baseURL: URL!
    public let path: String
    public let parameters: [String : Any]?
    public let httpMethod: HTTPMethod
    public let body: Data?

    public init(baseURL: URL, path: String, parameters: [String: Any]?, method: HTTPMethod, body: Data? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.parameters = parameters
        self.httpMethod  = method
        self.body = body
    }

    public init?(with url: URL, method: HTTPMethod, body: Data? = nil) {
        guard let components = URLComponents(string: url.absoluteString),
            let scheme = components.scheme,
            let host = components.host,
            let baseURL = URL(string: scheme + "://" + host) else { return nil }
        self.baseURL = baseURL
        self.path = components.path
        self.httpMethod = method
        self.body = body
        self.parameters = components.queryItems?.reduce(into: [:]) { $0[$1.name] = $1.value }
    }
}

public extension Endpoint {

    func makeRequest() -> URLRequest? {
        let url = self.baseURL.appendingPathComponent(path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        components.queryItems = parameters?.map { key, value in
            return URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
        }
        guard let resultURL = components.url else { return nil }
        var request = URLRequest(url: resultURL,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)

        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        return request
    }
}

