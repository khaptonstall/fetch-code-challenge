//
//  NetworkRequestPerformer.swift
//  Networking
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import Foundation

/// An object used to perform network requests against a set `URLSession`.
public final class NetworkRequestPerformer: Sendable {
    // MARK: Properties

    let taskHandler: NetworkTaskHandler

    // MARK: Initialization

    /// - Parameter urlSession: The object used to perform underlying network requests.
    public init(taskHandler: NetworkTaskHandler = URLSession.shared) {
        self.taskHandler = taskHandler
    }

    // MARK: Performing Requests
    
    /// Attempts performing the given network request and decoding into the request's `ResponseDataType`.
    /// If the network request object defines any response validators, they will be executed against the
    /// response object and throw an error if validation fails.
    public func performRequest<T: NetworkRequest>(_ networkRequest: T) async throws -> T.ResponseDataType {
        let request = try networkRequest.makeRequest()
        let (data, response) = try await taskHandler.data(for: request, delegate: nil)

        // Ensure we can get information about the HTTP response.
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingError.invalidResponseType
        }

        // Validate the response using any passed in validators.
        guard !networkRequest.responseValidators.contains(where: { $0.isValidResponse(httpResponse) == false }) else {
            throw NetworkingError.responseValidationFailed
        }

        // Finally, parse the response data and return it
        return try networkRequest.parseResponse(data: data)
    }
}
