//
//  URLRequestTests.swift
//  Networking
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import Foundation
@testable import Networking
import XCTest

final class URLRequestTests: XCTestCase {
    private static let baseURL = "https://google.com"

    func testMakeGetRequestWithoutHeaders() throws {
        // Create a GET request without any additional headers
        let request = try URLRequest.makeRequest(
            url: Self.baseURL,
            method: .get
        )

        XCTAssertEqual(request.httpMethod, HTTPMethod.get.rawValue)

        // Verify no additional headers were added onto the request.
        XCTAssertEqual(request.allHTTPHeaderFields, [:])
    }

    func testMakeGetRequestWithHeaders() throws {
        // Create a GET request
        let request = try URLRequest.makeRequest(
            url: Self.baseURL,
            method: .get,
            headers: ["Authorization": "Bearer xyz"]
        )

        XCTAssertEqual(request.httpMethod, HTTPMethod.get.rawValue)

        // Verify the headers were added correctly
        XCTAssertEqual(request.allHTTPHeaderFields?["Authorization"], "Bearer xyz")
    }
}
