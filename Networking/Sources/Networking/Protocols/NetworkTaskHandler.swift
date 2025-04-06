// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation

public protocol NetworkTaskHandler: Sendable {
    /// - Parameter request: The URLRequest for which to load data.
    /// - Parameter delegate: Task-specific delegate.
    /// - Returns: Data and response.
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkTaskHandler {}
