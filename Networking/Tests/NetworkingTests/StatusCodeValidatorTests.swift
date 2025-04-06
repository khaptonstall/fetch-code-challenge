// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation
@testable import Networking
import XCTest

final class StatusCodeValidatorTests: XCTestCase {
    func testValidationCatchesInvalidStatusCode() throws {
        let validator = StatusCodeValidator(invalidRange: 400 ..< 600)
        let response = try XCTUnwrap(HTTPURLResponse(statusCode: 500))
        XCTAssertFalse(validator.isValidResponse(response))
    }

    func testValidationIgnoresValidStatusCode() throws {
        let validator = StatusCodeValidator(invalidRange: 400 ..< 600)
        let response = try XCTUnwrap(HTTPURLResponse(statusCode: 200))
        XCTAssertTrue(validator.isValidResponse(response))
    }
}

// MARK: - Utilities

private extension HTTPURLResponse {
    convenience init?(statusCode: Int) {
        self.init(
            url: URL(string: "google.com")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )
    }
}
