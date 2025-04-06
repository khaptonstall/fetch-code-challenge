// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation
import Networking

/// A concrete implementation of `NetworkRequest` to be used as a test utility for mocking.
public struct MockNetworkRequest<T: Decodable>: NetworkRequest {
    public typealias ResponseDataType = T

    public let responseValidators: [URLResponseValidator]

    private let request: URLRequest
    private let decoder: JSONDecoder

    /// - Parameters:
    ///   - request: The url request this object represents
    ///   - responseValidators: Any validators that should be ran against a network response.
    ///   - decoder: A decoder to use when parsing response data.
    public init(
        request: URLRequest,
        responseValidators: [URLResponseValidator] = [],
        decoder: JSONDecoder = .init()
    ) {
        self.request = request
        self.responseValidators = responseValidators
        self.decoder = decoder
    }

    public func makeRequest() throws -> URLRequest {
        request
    }

    public func parseResponse(data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}
