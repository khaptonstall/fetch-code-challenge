// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation

public extension URLRequest {
    /// Convenience method used to generate a fully-formed `URLRequest`.
    /// - Parameters:
    ///   - url: The url for the request.
    ///   - method: The `HTTPMethod` used on the request.
    ///   - headers: Any headers to send along with the request.
    /// - Returns: A `URLRequest` that can then be used to perform a network call.
    static func makeRequest(
        url: String,
        method: HTTPMethod,
        headers: [String: String]? = nil
    ) throws -> Self {
        guard let url = URL(string: url) else {
            throw NetworkingError.unableToFormURLRequest
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
}
