//
//  URLResponseValidator.swift
//  Networking
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import Foundation

/// Defines a type that consumes an `HTTPURLResponse` and performs validation on that object.
public protocol URLResponseValidator: Sendable {
    /// Validates an `HTTPURLResponse`.
    /// - Parameter response: The response to validate.
    /// - Returns: Whether or not the response passed validation.
    func isValidResponse(_ response: HTTPURLResponse) -> Bool
}
