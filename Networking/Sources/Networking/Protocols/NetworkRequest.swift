// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation

/// Types conforming to `NetworkRequest` contain all the information used create the outgoing request and validate / parse the incoming response.
public protocol NetworkRequest: Sendable {
    associatedtype ResponseDataType

    /// An array of validation functions to run against the incoming network response.
    var responseValidators: [URLResponseValidator] { get }

    func makeRequest() throws -> URLRequest

    /// Called after performing a `URLRequest` in order to handle parsing of the response data.
    /// - Parameter data: The `Data` returned from the network.
    /// - Returns: The parsed and transformed data object.
    func parseResponse(data: Data) throws -> ResponseDataType
}
