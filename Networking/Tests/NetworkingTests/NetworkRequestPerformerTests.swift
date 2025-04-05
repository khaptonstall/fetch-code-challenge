//
//  NetworkRequestPerformerTests.swift
//  Networking
//
//  Created by Kyle Haptonstall on 4/5/25.
//

@testable import Networking
import MockNetworking
import XCTest

final class NetworkRequestPerformerTests: XCTestCase {

    /// Verifies performing a request will evaluate the network request's validators
    /// and throw an error on validation failure.
    func testPerformRequestUsesResponseValidators() async throws {
        // Setup a mock task handler to avoid real network calls
        let taskHandler = MockNetworkTaskHandler()
        let requestPerformer = NetworkRequestPerformer(taskHandler: taskHandler)

        // Create a request object that will validate we get a 2xx status code
        let urlRequest = try URLRequest.makeRequest(url: "https://google.com", method: .get)
        let mockRequest: MockNetworkRequest<MockResponseDataType> = MockNetworkRequest(
            request: urlRequest,
            responseValidators: [StatusCodeValidator()]
        )
        // Mock the request and return an invalid status code
        try await taskHandler.mockRequest(urlRequest, statusCode: 500, data: nil)


        // Perform the request and expect an error
        do {
            _ = try await requestPerformer.performRequest(mockRequest)
            XCTFail("Expected request to throw an error")
        } catch {
            XCTAssertEqual(error as? NetworkingError, .responseValidationFailed)
        }
    }

    /// Verifies performing a request with no validation errors and a properly formed data response
    /// will decode that data into the appropriate type.
    func testPerformRequestSuccessfullyParsesData() async throws {
        // Setup a mock task handler to avoid real network calls
        let taskHandler = MockNetworkTaskHandler()
        let requestPerformer = NetworkRequestPerformer(taskHandler: taskHandler)

        // Create a request object that will validate we get a 2xx status code
        let urlRequest = try URLRequest.makeRequest(url: "https://google.com", method: .get)
        let mockRequest: MockNetworkRequest<MockResponseDataType> = MockNetworkRequest(request: urlRequest)

        // Mock the request and return valid data.
        let data = try MockResponseDataType(id: "123").asData()
        try await taskHandler.mockRequest(urlRequest, statusCode: 200, data: data)

        // Perform the request and expect the decoded data
        let result = try await requestPerformer.performRequest(mockRequest)
        XCTAssertEqual(result.id, "123")
    }

}

// MARK: - Utilities

private struct MockResponseDataType: Codable {
    let id: String
}

