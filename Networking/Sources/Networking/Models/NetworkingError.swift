// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation

public enum NetworkingError: Error {
    /// Occurs when failing to generate a `URL` from the `URLComponents` object used create a `URLRequest`.
    case unableToFormURLRequest

    /// Occurs after performing a `URLRequest` but the response is not the expected `HTTPURLResponse` type
    case invalidResponseType

    case responseValidationFailed
}

// MARK: - LocalizedError

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToFormURLRequest:
            "Unable to form a URLRequest"
        case .invalidResponseType:
            "The response from the network request was not a valid HTTPURLResponse"
        case .responseValidationFailed:
            "Response validation failed"
        }
    }
}
