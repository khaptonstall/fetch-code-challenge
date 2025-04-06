// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation

/// A `URLResponseValidator` which ensures the `HTTPURLResponse` did not return a client or server error.
public struct StatusCodeValidator: URLResponseValidator {
    let invalidRange: Range<Int>

    // MARK: Initialization

    /// - Parameter invalidRange: A range of status codes which should be considered invalid.
    public init(invalidRange: Range<Int> = 400 ..< 600) {
        self.invalidRange = invalidRange
    }

    // MARK: Validation

    /// Validates the status code on the response does not fall in the invalid error ranges.
    /// - Parameter response: The response from the network request.
    /// - Returns: Whether or not the reponse passed validation.
    public func isValidResponse(_ response: HTTPURLResponse) -> Bool {
        let statusCode = response.statusCode
        return !invalidRange.contains(statusCode)
    }
}
