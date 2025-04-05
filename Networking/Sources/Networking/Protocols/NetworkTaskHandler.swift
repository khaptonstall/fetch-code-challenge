//
//  NetworkTaskHandler.swift
//  Networking
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import Foundation

public protocol NetworkTaskHandler: Sendable {

    /// - Parameter request: The URLRequest for which to load data.
    /// - Parameter delegate: Task-specific delegate.
    /// - Returns: Data and response.
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkTaskHandler {}
