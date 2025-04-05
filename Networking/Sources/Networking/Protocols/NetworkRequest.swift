//
//  NetworkRequest.swift
//  Networking
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import Foundation

public protocol NetworkRequest: Sendable {
    associatedtype ResponseDataType

    var responseValidators: [URLResponseValidator] { get }

    func makeRequest() throws -> URLRequest

    /// Called after performing a `URLRequest` in order to handle parsing of the response data.
    /// - Parameter data: The `Data` returned from the network.
    /// - Returns: The parsed and transformed data object.
    func parseResponse(data: Data) throws -> ResponseDataType
}
