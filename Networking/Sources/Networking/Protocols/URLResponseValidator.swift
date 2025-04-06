// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation

/// Defines a type that consumes an `HTTPURLResponse` and performs validation on that object.
public protocol URLResponseValidator: Sendable {
    /// Validates an `HTTPURLResponse`.
    /// - Parameter response: The response to validate.
    /// - Returns: Whether or not the response passed validation.
    func isValidResponse(_ response: HTTPURLResponse) -> Bool
}
