//
//  MockNetworkTaskHandler.swift
//  Networking
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import Foundation
import Networking

/// A concrete implementation of `NetworkTaskHandler` to be used as a test utility for mocking.
public actor MockNetworkTaskHandler {
    /// Key used to identify mocked network requests. Uses the form "<HTTP Method> <host>/<path>"
    /// Example: "GET www.google.com/path/to/resource"
    typealias MockedRequestKey = String

    struct MockedReponse {
        let httpMethod: HTTPMethod
        let statusCode: Int
        let data: Data?
    }

    enum MockNetworkError: Error {
        /// Occurs when mocking and a `URLRequest` is missing required properties, such as the httpMethod or url.
        case invalidURLRequest

        /// Occurs when the handler is called upon to handle a request that has no associated mock response.
        case requestNotMocked

        /// Occurs when attempting to create the `HTTPURLResponse` in response to a mocked network call fails.
        case mockingURLResponseFailed
    }

    // MARK: Properties

    private(set) var mockedRequests: [MockedRequestKey: MockedReponse] = [:]

    // MARK: Initialization

    public init() {}
    
    // MARK: Mocking

    public func mockRequest(_ request: URLRequest,
                            statusCode: Int,
                            data: Data?) throws {
        guard let rawHTTPMethod = request.httpMethod,
              let httpMethod = HTTPMethod(rawValue: rawHTTPMethod),
              let host = request.url?.host(),
              let path = request.url?.path() else {
            throw MockNetworkError.invalidURLRequest
        }

        mockRequest(
            httpMethod: httpMethod,
            host: host,
            path: path,
            statusCode: statusCode,
            data: data
        )
    }

    /// Mocks a network request to respond with the provided `statusCode` and `data`.
    /// - Parameters:
    ///   - httpMethod: The HTTP method to mock
    ///   - host: The host to mock (e.g. "www.google.com")
    ///   - path: The path to a given resource to mock, including a leading slash. (e.g. "/path/to/resource")
    ///   - statusCode: The status code to response with.
    ///   - data: The data to respond with.
    public func mockRequest(httpMethod: HTTPMethod,
                            host: String,
                            path: String = "",
                            statusCode: Int = 200,
                            data: Data? = nil) {
        let requestKey = "\(httpMethod.rawValue) \(host)\(path)"
        let mockedResponse = MockedReponse(httpMethod: httpMethod, statusCode: statusCode, data: data)
        mockedRequests[requestKey] = mockedResponse
    }

}

// MARK: - NetworkTaskHandler

extension MockNetworkTaskHandler: NetworkTaskHandler {
    public func data(
        for request: URLRequest,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse) {
        guard let url = request.url else { throw MockNetworkError.invalidURLRequest }

        let key = try mockedRequestKey(for: request)
        guard let mockedResponse = mockedRequests[key] else { throw MockNetworkError.requestNotMocked }

        guard let httpResponse = HTTPURLResponse(
            url: url,
            statusCode: mockedResponse.statusCode,
            httpVersion: nil,
            headerFields: nil
        ) else {
            throw MockNetworkError.mockingURLResponseFailed
        }

        return (mockedResponse.data ?? .init(), httpResponse)
    }

    private func mockedRequestKey(for request: URLRequest) throws -> MockedRequestKey {
        guard let httpMethod = request.httpMethod,
              let host = request.url?.host(),
              let path = request.url?.path() else {
            throw MockNetworkError.invalidURLRequest
        }

        return "\(httpMethod) \(host)\(path)"
    }
}
