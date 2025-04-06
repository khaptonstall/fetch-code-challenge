// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation

extension Encodable {
    func asData(encoder: JSONEncoder = .init()) throws -> Data {
        try encoder.encode(self)
    }
}
